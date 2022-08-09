// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract MulitSigWallet {
    event Deposit(address indexed sender, uint amount);
    event Submit(uint indexed txId);
    event Approve(address indexed owner, uint indexed txId);
    event Revoke(address indexed owner, uint indexed txId);
    event Excute(uint indexed txId);

    // 所有签名人钱包地址
    address[] public owners;
    mapping(address => bool) public isOwner;
    // 确认数 可发起交易的最小签名数量
    uint public required;

    // 交易数据
    struct Transaction {
        address to;
        uint value;
        bytes data;
        bool executed;
    }

    Transaction[] public transactions;
    // 交易 txId 的批准记录
    mapping(uint => mapping(address => bool)) public approved;

    modifier onlyOwner() {
        require(isOwner[msg.sender], "not owner");
        _;
    }

    modifier txExists(uint _txId) {
        require(_txId < transactions.length, "tx does not exist");
        _;
    }

    modifier notApproved(uint _txId) {
        require(!approved[_txId][msg.sender], "tx already approved");
        _;
    }

    modifier notExecuted(uint _txId) {
        require(!transactions[_txId].executed, "tx already executed");
        _;
    }

    constructor(address[] memory _owners, uint _required) {
        // 钱包数量要大于0
        require(_owners.length > 0, "owners required");
        // 确认数要大于0 且小于等于钱包数量
        require(_required > 0 && _required <= _owners.length, "invalid required number of owners");

        for (uint i; i < _owners.length; i++) {
            address owner = _owners[i];
            // 不能是0地址
            require(owner != address(0), "invalid owner");
            // 地址不能重复
            require(!isOwner[owner], "owner is not unique");

            // 添加钱包
            isOwner[owner] = true;
            owners.push(owner);
        }

        // 修改确认数
        required = _required;
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    // 提交
    function submit(address _to, uint _value, bytes calldata _data) external onlyOwner {
        transactions.push(Transaction({
            to: _to,
            value: _value,
            data: _data,
            executed: false
        }));

        emit Submit(transactions.length - 1);
    }

    // 批准
    function approve(uint _txId) external onlyOwner txExists(_txId) notApproved(_txId) notExecuted(_txId) {
        approved[_txId][msg.sender] = true;
        emit Approve(msg.sender, _txId);
    }

    // 撤销批准
    function revoke(uint _txId) external onlyOwner txExists(_txId) notExecuted(_txId) {
        require(approved[_txId][msg.sender], "tx not approved");
        approved[_txId][msg.sender] = false;
        emit Revoke(msg.sender, _txId);
    }

    // 获取一个交易的批准数量
    function _getApprovalCount(uint _txId) private view returns (uint count) {
        for (uint i; i < owners.length; i++) {
            if (approved[_txId][owners[i]]) {
                count += 1;
            }
        }
    }

    // 执行
    function execute(uint _txId) external txExists(_txId) notExecuted(_txId) {
        require(_getApprovalCount(_txId) >= required, "approvals < required");

        Transaction storage transaction = transactions[_txId];
        transaction.executed = true;
        (bool success, bytes memory data) = transaction.to.call{value: transaction.value}(transaction.data);

        require(success, " tx failed");

        emit Excute(_txId);
    }
}
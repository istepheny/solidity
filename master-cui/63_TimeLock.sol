// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// 时间锁合约
contract TimeLock {
    error NotOwnerError();
    error AlreadyQueuedError(bytes32 txId);
    error TxFailedError(bytes32 txId);
    error NotQueuedError(bytes32 txId);
    error TimestampNotInRangeError(
        bytes32 txId,
        uint256 blockTimestamp,
        uint256 timestamp
    );
    error TimestampNotPassedError(
        bytes32 txId,
        uint256 blockTimestamp,
        uint256 timestamp
    );

    event Queue(
        bytes32 indexed txId,
        address indexed target,
        uint256 value,
        string func,
        bytes data,
        uint256 timestamp
    );

    event Execute(
        bytes32 indexed txId,
        address indexed target,
        uint256 value,
        string func,
        bytes data,
        uint256 timestamp
    );

    event Cancel(bytes32 indexed txId);

    uint256 public constant MIN_DELAY = 10;
    uint256 public constant MAX_DELAY = 1000;

    address public owner;
    mapping(bytes32 => bool) queued;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert NotOwnerError();
        }
        _;
    }

    // 创建交易id
    function getTxId(
        address _target,
        uint256 _value,
        string calldata _func,
        bytes calldata _data,
        uint256 _timestamp
    ) public pure returns (bytes32 txId) {
        return keccak256(abi.encode(_target, _value, _func, _data, _timestamp));
    }

    function queue(
        address _target,
        uint256 _value,
        string calldata _func,
        bytes calldata _data,
        uint256 _timestamp
    ) external onlyOwner {
        // 创建交易id
        bytes32 txId = getTxId(_target, _value, _func, _data, _timestamp);
        // 检查交易id是否已经存在
        if (queued[txId]) {
            revert AlreadyQueuedError(txId);
        }
        // 检查时间戳
        if (
            _timestamp < block.timestamp + MIN_DELAY ||
            _timestamp > block.timestamp + MAX_DELAY
        ) {
            revert TimestampNotInRangeError(txId, block.timestamp, _timestamp);
        }
        // 执行队列里的交易
        queued[txId] = true;

        emit Queue(txId, _target, _value, _func, _data, _timestamp);
    }

    function execute(
        address _target,
        uint256 _value,
        string calldata _func,
        bytes calldata _data,
        uint256 _timestamp
    ) external payable onlyOwner returns (bytes memory) {
        // 获取交易id
        bytes32 txId = getTxId(_target, _value, _func, _data, _timestamp);
        if (!queued[txId]) {
            revert NotQueuedError(txId);
        }
        // 检查时间戳
        if (block.timestamp < _timestamp) {
            revert TimestampNotPassedError(txId, block.timestamp, _timestamp);
        }
        // 从队列里删除交易
        queued[txId] = false;
        // 执行
        bytes memory data = getSelector(_func, _data);
        (bool ok, bytes memory result) = _target.call{value: _value}(data);
        if (!ok) {
            revert TxFailedError(txId);
        }

        emit Execute(txId, _target, _value, _func, _data, _timestamp);

        return result;
    }

    function getSelector(string calldata _func, bytes calldata _data)
        internal
        pure
        returns (bytes memory)
    {
        if (bytes(_func).length > 0) {
            return abi.encodePacked(bytes4(keccak256(bytes(_func))), _data);
        } else {
            return _data;
        }
    }

    function cancel(bytes32 _txId) external onlyOwner {
        if (!queued[_txId]) {
            revert NotQueuedError(_txId);
        }

        queued[_txId] = false;
        emit Cancel(_txId);
    }
}

contract TestTimeLock {
    address public timeLock;

    constructor(address _timelock) {
        timeLock = _timelock;
    }

    function test() external view {
        require(msg.sender == timeLock);
    }

    function getTimestamp() external view returns (uint256) {
        return block.timestamp + 100;
    }
}

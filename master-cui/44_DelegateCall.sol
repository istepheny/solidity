// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 委托调用
// 使用被调用的合约中的函数逻辑，操作委托合约中的状态值，被调用合约的代码可以任意升级，用于制作可升级的合约
contract DelegataCall {
    uint public num;
    address public sender;
    uint public value;

    // 委托合约调用
    function setVars(address _addr, uint _num) external payable {
        (bool success, bytes memory data) = _addr.delegatecall(
            abi.encodeWithSelector(TestDelegateCall.setVars.selector, _num)
        );

        require(success,"delegatecall failed");
    }
}

contract TestDelegateCall {
    uint public num;
    address public sender;
    uint public value;

    // 具体的业务逻辑，可任意修改
    function setVars(uint _num) external payable {
        num = 2 * _num;
        sender = msg.sender;
        value = msg.value;
    }
}
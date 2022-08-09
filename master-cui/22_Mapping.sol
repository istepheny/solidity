// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Mapping{
    // 简单映射 账户余额
    mapping(address => uint) public balances;
    // 嵌套映射 查看是否是好友关系
    mapping(address => mapping(address => bool)) public isFriend;

    function foo() public{
        balances[msg.sender]=123;
        uint bal = balances[msg.sender];

        // 映射中不存在的索引，获取到的是零值
        uint bal2 = balances[address(1)];

        balances[msg.sender]+=456;

        // 删除数据
        delete balances[msg.sender];

        // 嵌套映射的数据定义
        isFriend[msg.sender][address(this)]=true;
    }
}
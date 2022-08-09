// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 不可变量 immutable 合约部署时赋值
// 既能像常量 const 一样节省 gas，又能在合约部署时才定义变量值
contract Immutable {
    address public immutable owner;

    constructor(){
        owner = msg.sender;
    }
}
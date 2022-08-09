// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Constructor {
    address public owner;
    uint public x;

    // 构造函数 只在合约部署时调用一次
    constructor(uint _x){
        owner = msg.sender;
        x=_x;
    }
}

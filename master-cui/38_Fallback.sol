// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 回退函数的触发时机
// 1，调用了不存在的函数 2，直接向合约发送主币
// fallback 可以接受主币和数据
// receive  只接受主币 不接受数据
contract Fallback {
    event Log(string func, address sender, uint value, bytes data);

    fallback() external payable {
        emit Log("fallback", msg.sender, msg.value, msg.data);
    }

    receive() external payable {
        emit Log("receive", msg.sender, msg.value, "");
    }
}
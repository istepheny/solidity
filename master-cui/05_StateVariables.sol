// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

contract StateVariables {
    // 状态变量 会永久记录在区块链上
    uint public myUint = 123;

    function foo() external pure {
        // 非状态变量 只在调用函数时才会产生
        uint notStateVariables = 456;
    }
}
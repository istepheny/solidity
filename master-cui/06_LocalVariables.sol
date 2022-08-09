// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

contract LocalVariables {
    uint public i;
    bool public b;
    address public myAddress;

    function foo() external {
        // 局部变量
        uint x = 123;
        bool f = false;
        x+=456;
        f=true;

        // 在函数中修改状态变量
        i=123;
        b=true;
        myAddress=address(1);
    }
}
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

// 函数返回值
contract FUnctionOutPuts{
    // 返回多个值
    function returnsMany() public pure returns (uint, bool){
        return (1, true);
    }

    // 给返回值命名
    function named() public pure returns (uint x, bool b){
        return (1, true);
    }

    // 隐式返回
    function assigned() public pure returns (uint x, bool b){
        x=1;
        b=true;
    }

    // 调用函数返回值
    function destructingAssigments() public pure {
        // (uint x, bool b) = returnsMany();
        // 用不到的返回值可以省略
        (, bool b) = returnsMany();
    }
}

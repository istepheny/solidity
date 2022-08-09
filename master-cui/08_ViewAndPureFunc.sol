// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

// 只读函数
contract ViewAndPureFunc {
    uint public num;

    // view 可以访问状态变量
    function viewFunc() external view returns(uint){
        return num;
    }

    // pure 不能访问状态变量
    function pureFunc() external pure returns(uint){
        return 1;
    }

    function addToNum(uint x) external view returns(uint){
        return num + x;
    }

    function add(uint x,uint y) external pure returns(uint){
        return x + y;
    }
}
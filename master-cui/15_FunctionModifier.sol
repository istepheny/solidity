// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

// 函数修改器
contract FunctionModifier {
    bool public paused;
    uint public count;

    function setPaused(bool pause) external {
        paused = pause;
    }

    modifier whenNotPaused(){
        require(!paused,"paused");
        _;
    }

    function inc() external whenNotPaused{
        count += 1;
    }

    function dec() external whenNotPaused{
        count = 1;
    }

    // 带参数的修改器
    modifier cap(uint x){
        require(x<100,"x>100");
        _;
    }

    function incBy(uint x) external whenNotPaused cap(x){
        count+=x;
    }

    // 三明治式修改器
    modifier sandwich(){
        count+=1;
        _;
        count+=2;
    }

    function foo() external sandwich{
        count+=1;
    }
}

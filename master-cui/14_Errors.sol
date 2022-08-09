// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

// 报错控制
contract Errors {
    function testRequire(uint i) public pure {
        // 要求i<=10，否则就报错
        require(i<=10, "i>10");
    }

     function testRevert(uint i) public pure {
        if (i>10){
            revert("i>10");
        }
    }

    uint public num = 123;
    function testAssert() public view{
        assert(num==123);
    }

    function foo(uint i) public{
        num+=1;
        require(i<10);
    }

    // 自定义错误
    error MyError(address caller, uint i,string message);

    function testCustomError(uint i) public view{
        if ( i > 10 ) {
            revert MyError(msg.sender, i,"very long error message error error error error error error error");
        }
    }
}

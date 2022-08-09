// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

// 继承
contract A {
    // virtual 表示该方法可以被重写
    function foo() public pure virtual returns (string memory) {
        return "A";
    }
    
    function bar() public pure virtual returns (string memory) {
        return "A";
    }

    function baz() public pure returns (string memory) {
        return "A";
    }
}

contract B is A {
    // override 表示重写方法
    function foo() public pure override returns (string memory) {
        return "B";
    }
    
    // 重写过的方法 可以被再次重写
    function bar() public pure virtual override returns (string memory) {
        return "B";
    }
}

contract C is B {
    function bar() public pure override returns (string memory) {
        return "C";
    }
}
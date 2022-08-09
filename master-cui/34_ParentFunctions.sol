// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 调用父级合约函数
contract E {
    event Log(string message);

    function foo() public virtual {
        emit Log("E.foo");
    }

    function bar() public virtual {
        emit Log("E.bar");
    }
}

contract F is E {
    function foo() public virtual override {
        emit Log("F.foo");
        // 写法1
        E.foo();
    }

    function bar() public virtual override {
        emit Log("F.bar");
        // 写法2
        super.bar();
    }
}

contract G is E {
    function foo() public virtual override {
        emit Log("G.foo");
        E.foo();
    }

    function bar() public virtual override {
        emit Log("G.bar");
        super.bar();
    }
}

contract H is F, G {
    function foo() public override(F, G) {
        F.foo();
    }

    function bar() public override(F, G) {
        // 多继承 所有父合约的 bar 方法都会触发
        super.bar();
    }
}
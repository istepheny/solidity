// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 运行父级合约构造函数
contract S {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

contract T {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

// 方法一：在继承中传参
contract U is S("s"), T("t") {

}

// 方法二：在子合约的构造函数中传参
contract V is S, T {
    constructor(string memory _name, string memory _text) S(_name) T(_text) {

    }
}

// 方法三：混合传参
contract VV is S("s"), T {
    constructor(string memory _text) T(_text){

    }
}
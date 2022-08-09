// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

// 常量 不需要修改的值可以定义为常量 读取常量比读取变量节省gas费
contract Constants {
    address public constant MY_ADDRESS = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    uint public constant MY_UINT = 123;
}

// 变量
contract Var {
    address public MY_ADDRESS = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
}
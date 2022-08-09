// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 哈希运算
contract HashFunc {
    // abi.encodePacked 打包16进制数据 每个变量之间不会补0 有可能出现不同变量产生相同16进制数据
    function hash(string memory text, uint num, address addr) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(text, num, addr));
    }

    // abi.encode 打包16进制数据 每个变量之间补0
    function hash2(string memory text, uint num, address addr) external pure returns (bytes32) {
        return keccak256(abi.encode(text, num, addr));
    }
}
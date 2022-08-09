// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// ABI编解码
contract ABIDecode {
    // 在remix 中输入结构体类型参数的方法
    // ["test",[1,2]]
    struct MyStruct {
        string name;
        uint[2] nums;
    }

    function encode(uint x, address addr, uint[] calldata arr, MyStruct calldata myStruct) external pure returns (bytes memory data){
        return abi.encode(x, addr, arr, myStruct);
    }

    function decode(bytes calldata data) external pure returns (uint x, address addr, uint[] memory arr, MyStruct memory myStruct) {
        return abi.decode(data, (uint, address, uint[], MyStruct));
    }
}
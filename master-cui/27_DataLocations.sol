// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

// 存储位置
contract DataLocations{
    struct MyStruct {
        uint foo;
        string text;
    }

    mapping(address => MyStruct) public myStructs;

    function examples(uint[] calldata y, string calldata s) external returns (uint[] memory) {
        myStructs[msg.sender] = MyStruct({foo: 123, text: "bar"});
        // storage 状态变量
        MyStruct storage myStruct = myStructs[msg.sender];
        myStruct.text = "foo";

        // memory 局部变量 只在内存中生效 修改了值 也不会修改状态变量
        MyStruct memory readOnly = myStructs[msg.sender];
        readOnly.foo = 456;

        _internal(y);

        uint[] memory memArr = new uint[](3);
        memArr[0] = 234;
        return memArr;
    }

    // calldata 只能在参数中使用 节约内部方法调用时参数传递的gas
    function _internal(uint[] calldata y) private{
        uint x = y[0];
    }
}
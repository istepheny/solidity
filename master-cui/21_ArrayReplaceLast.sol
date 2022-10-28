// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

// 删除数组中的元素并改变长度
contract ArrayShift{
    uint[] public arr;

    function remove(uint index) public{
        arr[index]=arr[arr.length-1];
        arr.pop();
    }

    function test() public {
        arr = [1,2,3,4];
        remove(1);

        assert(arr.length==3);
        assert(arr[0]==1);
        assert(arr[1]==4);
        assert(arr[2]==3);
    }
}
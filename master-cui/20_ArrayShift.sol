// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

// 删除数组中的元素并改变长度
contract ArrayShift{
    uint[] public arr;


    function foo() public{
        arr=[1,2,3];
    }

    function remove(uint index) public{
        require(index<arr.length,"index out of bound");
        
        for(uint i = index;i<arr.length-1;i++){
            arr[i]=arr[i+1];
        }
        arr.pop();
    }

    function test() public{
        arr=[1,2,3,4,5];
        remove(2); // [1,2,4,5]
        assert(arr[0]==1);
        assert(arr[1]==2);
        assert(arr[2]==4);
        assert(arr[3]==5);
        assert(arr.length==4);

        arr=[1];
        remove(0);
        assert(arr.length==0);
    }
}
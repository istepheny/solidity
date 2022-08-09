// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

// 数组
contract Array{
    // 动态数组
    uint[] public nums = [1,2,3];
    // 定长数组
    uint[3] public numsFixed = [4,5,6];

    function example() external{
        nums.push(4); // [1,2,3,4]
        uint x = nums[1];
        nums[2] = 777; // [1,2,777,4]
        // 删除数组中的元素，不会改变数组长度，删除的索引会变成默认值
        delete nums[1]; // [1,0,777,4]
        // 弹出数组最后一个值
        nums.pop();
        // 获取数组长度
        uint len = nums.length;

        // 在内存中创建数组，是局部变量，只能创建定长数组
        uint[] memory a = new uint[](5);
        a[1]=123;
    }

    function returnArray() external view returns (uint[] memory){
        return nums;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// 节约gas
contract GasGolf {
    // 初始状态 58227
    // 使用calldata 56124
    // 状态变量加载到内存中 55881
    // if判断短路 55516
    // 循环增量 i++ 换成 ++i 55481
    // 缓存数组的长度 55441
    // 数组元素加载到内存中 55255
    uint public total;

    // [1,2,3,4,5,100]
    function sumIfEvenAndLessThan99(uint[] calldata nums) external {
        // 状态变量加载到内存中
        uint _total = total;
        // 缓存数组的长度
        uint len = nums.length;
        for (uint i = 0; i < len; ++i) {
            // bool isEven = nums[i] % 2 == 0;
            // bool isLessThan99 = nums[i] < 99;
            // 数组元素加载到内存中
            uint num = nums[i];
            if(num % 2 == 0 && num < 99) {
                _total += num;
            }
        }
        total = _total;
    }
}
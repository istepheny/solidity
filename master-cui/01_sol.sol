// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// solidity 0.8 新特性
// 安全数学
contract SafeMath {
    function testUnderflow() public pure returns (uint) {
        uint x = 0;
        // uint 没有负数，0继续减，会报错 revert
        x--;
        return x;
    }

    function testUncheckedUnderflow() public pure returns (uint) {
        uint x = 0;
        // 关闭安全数学检查，0继续减，不会报错，会溢出，得到的是 uint256 的最大值
        unchecked { x--; }
        return x;
    }
}

// 自定义错误
contract VendingMachine {
    address payable owner = payable(msg.sender);

    // 自定义错误可以接受变量，还比直接 revert 字符串节约 gas
    error Unauthorized(address caller);

    function withdraw() public view {
        if (msg.sender != owner) {
            revert Unauthorized(msg.sender);
        }
    }
}

// 函数可以在合约外定义
function helper(uint x) pure returns (uint) {
    return x * 2;
}

contract TestHelper {
    function test() external pure returns (uint) {
        return helper(123);
    }
}

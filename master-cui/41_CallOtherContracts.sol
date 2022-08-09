// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 调用其他合约
contract CallTestContract {
    function setX(address _addr, uint _x) external {
        TestContract(_addr).setX(_x);
    }

    function getX(address _addr) external view returns (uint) {
        return TestContract(_addr).getX();
    }

    function setXandReceiveEther(address _addr, uint _x) external payable {
        TestContract(_addr).setXandReceiveEther{value: msg.value}(_x);
    }

    function getXandValue(address _addr) external view returns (uint x, uint value) {
        return TestContract(_addr).getXandValue();
    }
}

// 被调用的合约
contract TestContract {
    uint public x;
    uint public value;

    function setX(uint _x) external {
        x = _x;
    }

    function getX() external view returns (uint) {
        return x;
    }

    function setXandReceiveEther(uint _x) external payable {
        x = _x;
        value = msg.value;
    }

    function getXandValue() external view returns (uint, uint) {
        return (x, value);
    }
}
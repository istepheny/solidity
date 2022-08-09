// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 自毁合约 selfdestruct
// 1，删除合约
// 2，强制发送主币到任意地址，如果目标地址是合约，即使没有fallback函数，也可以发送成功

contract Kill {
    constructor() payable {}

    function kill() external {
        selfdestruct(payable(msg.sender));
    }

    function testCall() external pure returns (uint) {
        return 123;
    }
}

contract Helper {
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    function kill(Kill _kill) external {
        _kill.kill();
    }
}
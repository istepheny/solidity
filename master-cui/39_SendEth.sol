// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 发送主币
// transfer 失败时抛出异常，发送 2300 gas 的矿工费，不可调节。
// send 失败时返回 false，发送 2300 gas 的矿工费用，不可调节。
// call 发送所有可用 gas，返回 bool 和 data，如果主币发送目标地址是合约，合约有返回值，会在 data 里

contract SendEther{
    constructor () payable {}
    
    receive() external payable {}

    function sendViaTransfer(address payable to, uint amount) external payable {
        to.transfer(amount);
    }

    function sendViaSend(address payable to, uint amount) external payable {
        bool sent = to.send(amount);
        require(sent, "send failed");
    }

    function sendViaCall(address payable to, uint amount) external payable {
        (bool success, bytes memory data) = to.call{value: amount}("");
        require(success, "send failed");
    }
}

contract EthReceiver {
    event Log(uint amount, uint gas);

    receive() external payable {
        emit Log(msg.value, gasleft());
    }
}

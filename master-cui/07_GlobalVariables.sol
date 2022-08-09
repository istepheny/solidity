// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

contract GlobalVariables {
    // 全局变量 不用定义就能使用的变量
    function globalVars() external view returns(address,uint,uint) {
        // 函数调用者的地址，可能是一个钱包地址，也可能是另一个合约地址
        address sender = msg.sender;
        // 区块时间戳
        uint timestamp = block.timestamp;
        // 区块编号
        uint blockNum = block.number;
        return (sender,timestamp,blockNum);
    }
}
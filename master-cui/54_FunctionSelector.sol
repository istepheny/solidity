// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// 函数签名
contract Receiver {
    event Log(bytes data);

    function transfer(address _to, uint _amount) external {
        emit Log(msg.data);
        // 0xa9059cbb
        // 0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc4
        // 000000000000000000000000000000000000000000000000000000000000000b
    }
}

// 虚拟机找到函数的原理，取函数签名哈希值的前4位16进制数
contract FunctionSelector {
    // "transfer(address,uint256)" 运算结果是 0xa9059cbb
    function getSelector(string calldata _func) external pure returns (bytes4) {
        return bytes4(keccak256(bytes(_func)));
    }
}
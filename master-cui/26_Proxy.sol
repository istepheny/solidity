// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract TestContract1{
    address public owner = msg.sender;

    function setOwner(address _owner) public {
        require(msg.sender == owner,"not owner");
        owner = _owner;
    }
}

contract TestContract2{
    address public owner = msg.sender;
    uint public value = msg.value;
    uint public x;
    uint public y;

    constructor(uint _x,uint _y) payable {
        x=_x;
        y=_y;
    }
}

// 代理合约
contract Proxy{
    event Deploy(address);

    function deploy(bytes memory code) external payable returns (address addr){
        assembly{
            // create(v,p,n)
            // v 要发送的主币数量
            // p 代码在内存中开始的位置
            // n 代码的大小
            addr := create(callvalue(), add(code,0x20), mload(code))
        }

        // 确认部署是否成功
        require(addr != address(0),"deploy failed");

        emit Deploy(addr);
    }

    error MyError(address caller,bytes data);

    function execute(address _target, bytes memory _data) external payable {
        // 用16进制数据包调用合约方法
        (bool success, bytes memory data) = _target.call{value:msg.value}(_data);
        if(!success){
            revert MyError(_target, data);
        }
    }
}

contract Helper {
    function getByteCode1() external pure returns (bytes memory) {
        // 获取合约的bytecode
        bytes memory bytecode = type(TestContract1).creationCode;
        return bytecode;
    }

    function getByteCode2(uint _x, uint _y) external pure returns (bytes memory) {
        // 获取有构造函数的合约的bytecode
        bytes memory bytecode = type(TestContract2).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_x, _y));
    }

    function getCalldata(address _owner) external pure returns (bytes memory) {
        // 构造合约方法调用的16进制数据包
        return abi.encodeWithSignature("setOwner(address)", _owner);
    }
}
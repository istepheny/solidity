// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// 被部署的合约
contract DeloyWithCreate2 {
    address public owner;

    constructor(address _owner) {
        owner = _owner;
    }
}

// Create2 部署合约
contract Create2Factory {
    event Deploy(address addr);

    // 使用工厂合约地址+盐 可以计算新部署合约的地址
    function deploy(uint _salt) external {
        DeloyWithCreate2 _contract = new DeloyWithCreate2{
            salt: bytes32(_salt)
        }(msg.sender);
        emit Deploy(address(_contract));
    }

    // 计算新合约地址
    function getAddress(bytes memory bytecode, uint _salt) public view returns (address) {
        bytes32 hash = keccak256(
            abi.encodePacked(
                bytes1(0xff), address(this), _salt, keccak256(bytecode)
            )
        );

        return address(uint160(uint(hash)));
    }

    // 获取合约bytecode
    function getBytecode(address _owner) public pure returns (bytes memory) {
        bytes memory bytecode = type(DeloyWithCreate2).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_owner));
    }
}
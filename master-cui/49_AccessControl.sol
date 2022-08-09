// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 角色权限控制合约
contract AccessControl {
    event GrantRole(bytes32 indexed role, address indexed account);
    event RevokeRole(bytes32 indexed role, address indexed account);

    mapping(bytes32 => mapping(address => bool)) public roles;

    // 0xdf8b4c520ffe197c5343c6f5aec59570151ef9a492f2c624fd45ddde6135ec42
    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    // 0x2db9fd3d099848027c2383d0a083396f6c41510d7acfd92adc99b6cffcf31e96
    bytes32 private constant USER = keccak256(abi.encodePacked("USER"));

    modifier onlyRole(bytes32 role) {
        require(roles[role][msg.sender], "not authorized");
        _;
    }

    constructor() {
        _grantRole(ADMIN, msg.sender);
    }

    function _grantRole(bytes32 role, address account) internal {
        roles[role][account] = true;
        emit GrantRole(role, account);
    }

    function grantRole(bytes32 role, address account) external onlyRole(ADMIN) {
        _grantRole(role, account);
    }

    function _revokeRole(bytes32 role, address account) internal {
        roles[role][account] = false;
        emit RevokeRole(role, account);
    }

    function revokeRole(bytes32 role, address account) external onlyRole(ADMIN) {
        _revokeRole(role, account);
    }
}
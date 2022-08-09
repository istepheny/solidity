// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

// 映射迭代
contract IterableMapping{
    mapping(address => uint) balances;
    mapping(address => bool) inserted;

    address[] addresses;

    function set(address addr, uint val) external {
        balances[addr] = val;

        if(!inserted[addr]){
            inserted[addr]=true;
            addresses.push(addr);
        }
    }

    function get(address addr) external view returns (uint){
        return balances[addr];
    }
}
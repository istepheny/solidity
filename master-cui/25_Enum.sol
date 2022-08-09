// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

// 枚举
contract Enum{
    enum Status{
        None,
        Pending,
        Shipped,
        Completed,
        Rejected,
        Canceled
    }

    Status public status;

    struct Order{
        address buyer;
        Status status;
    }

    Order[] public orders;

    // 获取枚举值
    function get() public view returns (Status){
        return status;
    }

    // 设置枚举值
    function set(Status _status) external {
        status = _status;
    }

    // 设置枚举值为特定的值
    function ship() external {
        status = Status.Shipped;
    }

    // 恢复枚举值为默认值
    function reset() external {
        delete status;
    }
}
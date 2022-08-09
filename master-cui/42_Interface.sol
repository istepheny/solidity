// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 接口合约
interface ICounter {
    function count() external view returns (uint);
    function inc() external;
}

contract Counter {
    uint public count;

    function inc() external {
        count += 1;
    }

    function dec() external {
        count -= 1;
    }
}

contract CallInterface {
    uint public count;

    function examples(address _counter) external {
        ICounter(_counter).inc();
        count = ICounter(_counter).count();
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 低级 call
contract TestCall {
    string public message;
    uint public x;

    event Log(string message);

    fallback() external payable {
        emit Log("fallback was called");
    }

    function foo(string memory _message, uint _x) external payable returns (bool, uint) {
        message = _message;
        x = _x;
        return (true, 999);
    }
}

contract Call {
    function callFoo(address addr) external payable {
        (bool success, bytes memory data) = addr.call{value: msg.value}(
            abi.encodeWithSignature(
                "foo(string,uint256)","call foo",123
                )
            );
        
        require(success, "call failed");
    }

    function callDoesNotExit(address addr) external {
        (bool success, bytes memory data) = addr.call(abi.encodeWithSignature("doesNotExist()"));
    }
}

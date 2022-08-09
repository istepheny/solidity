// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract MultiDelegateCall {
    error DelegatecallFailed();

    function multiDelegateCall(bytes[] calldata data) external payable returns(bytes[] memory results){
        results = new bytes[](data.length);

        for(uint i; i < data.length; i++){
            (bool ok, bytes memory result) = address(this).delegatecall(data[i]);
            if (!ok) {
                revert DelegatecallFailed();
            }
            results[i] = result;
        }

        return results;
    }
}

// 为什么要使用多重委托调用？为什么不用多重调用？
// 用户 -> 多重调用 -> test(msg.sender = 执行多重调用的合约的地址)
// 用户 -> test() -> 多重委托调用 -> test(msg.sender = 用户的地址)
// 委托调用合约不能单独存在，不能调用其他合约，只能调用自身合约，需要继承到被调用的合约上
// 如何合约不是自己写的，就无法使用委托调用
contract TestMultiDelegateCall is MultiDelegateCall {
    event Log(address caller, string fnuc, uint i);

    function func1(uint x, uint y) external {
        emit Log(msg.sender, "func1", x + y);
    }

    function func2() external returns (uint) {
        emit Log(msg.sender, "func2", 2);
        return 111;
    }

    mapping(address => uint) public balanceOf;

    // 多重委托调用处理接受主币操作的漏洞，发送一次主币就可以增加多次主币余额
    // 解决方法1，在多重委托调用的逻辑中，不要重复计算主币数量
    // 解决方法2，让多重委托调用的方法不能接受主币
    function mint() external payable {
        balanceOf[msg.sender] += msg.value;
    }
}

contract Helper {
    function getFunc1Data(uint x, uint y) external pure returns (bytes memory) {
        return abi.encodeWithSelector(TestMultiDelegateCall.func1.selector, x, y);
    }

    function getFunc2Data() external pure returns (bytes memory) {
        return abi.encodeWithSelector(TestMultiDelegateCall.func2.selector);
    }

    function getMintData() external pure returns (bytes memory) {
        return abi.encodeWithSelector(TestMultiDelegateCall.mint.selector);
    }
}
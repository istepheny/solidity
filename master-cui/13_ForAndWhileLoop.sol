// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

// 循环
contract ForAndWhildLoop {
    function loops() external pure {
        for(uint i = 0; i < 10;i++) {
            if (i == 3) {
                continue;
            }
            if (i == 5) {
                break;
            }
        }

        uint j = 0;
        while(j<10){
            j++;
        }
    }

    function sum(uint n) external pure returns (uint){
        uint s;
        for(uint i = 1;i<n;i++){
            s+=i;
        }
        return s;
    }
}

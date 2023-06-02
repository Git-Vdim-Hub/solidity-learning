//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

// "setMyUint(uint256)"
//web3.utils.sha3("setMyUint(uint256)")

//0xe492fd840000000000000000000000000000000000000000000000000000000000000001
//0xe492fd84 << function identifier


contract SampleFallback {
    uint public lastValueSent;
    string public lastFunctionCalled;
    uint public myUint;

    function setMyUint(uint _myNewUint) public {
        myUint = _myNewUint;
    }

    receive() external payable {
        lastValueSent = msg.value;
        lastFunctionCalled = "receive";
    }

    fallback() external payable {
        lastValueSent = msg.value;
        lastFunctionCalled = "fallback";
    }
}

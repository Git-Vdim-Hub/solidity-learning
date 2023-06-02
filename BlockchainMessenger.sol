//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract BlockchainMessenger {
    address public owner;
    uint public changeCounter;
    string public theMessage;
    constructor(){
        owner=msg.sender;
    }
    function changeMessage(string memory _newMessage) public{
        if (msg.sender==owner){
            changeCounter++;
            theMessage=_newMessage;
        }
    }
}

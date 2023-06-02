//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract MyContract {
    string public ourString = "Hello World";
    bool public isCool;
    uint256 myUint; //0.-.(2^256) -1 (cannot go below zero)
    uint8 my8Uint; //-2^128.-.2^128 -1
    int myInt = -10; // (can be negative)
    bytes public myBytes = "Hello World";
    address public myAddress;
    uint public myStorageVariable;

    constructor(address _someAddress){
        myAddress = _someAddress;
    }


    function getMyStorageVariable() public view returns(uint){
        return myStorageVariable;
    }

    function getAddition (uint a, uint b) public pure returns (uint) {
        return a+b;
    }

    function updateMyAddress() public {
        myAddress = msg.sender;
    }

    function setSomeAddress( address _someAddress) public {
        myAddress = _someAddress;
    }

    function getAddressBalance() public view returns(uint256){
        return myAddress.balance;
    }


    function updateOurString(string memory _updateString) public {
        ourString = _updateString;
    }

    function updateCoolStatus(bool _updateIsCool) public {
        isCool = _updateIsCool;
    }

    function setMyString(string memory _myString) public {
        ourString = _myString;
    }

    function compareTwoStrings(string memory _myString) public view returns (bool) {
        return keccak256(abi.encodePacked(ourString)) == keccak256(abi.encodePacked(_myString));
    }

    function getBytesLength() public view returns (uint){
        return myBytes.length;
    }
}

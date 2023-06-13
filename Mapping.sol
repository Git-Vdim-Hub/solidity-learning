//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract Mapping {
    mapping (uint => bool) public myMapping;
    mapping(address => bool) public myAddressMapping;
    mapping(uint => mapping(uint => bool)) public uintUintBoolMapping;
    function setValue(uint _index) public {
        myMapping[_index]=true;
    }

    function setMyAddressToTrue() public {
        myAddressMapping[msg.sender] = true; // its using an address as the index (not an integer) thats very interesting/different
    }
    // mappings are not like arrays, they are more like object arrays because they access data key to find the value, what ever that key is.
    function setUintUintBoolMapping(uint _key1, uint _key2, bool _value) public {
        uintUintBoolMapping[_key1][_key2] = _value;
    }
}

contract Mapping2 {

    mapping (address => uint) public balanceRecieved;

    function sendMoney() public payable {
        balanceRecieved[msg.sender] +=msg.value;
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function withdrawAllMoney(address payable _to) public {
        uint balanceToSendOut = balanceRecieved[msg.sender];
        balanceRecieved[msg.sender] = 0;
        _to.transfer(balanceToSendOut);
    }
}

//SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

contract ContractWallet {
    address payable walletOwner;

    mapping(address => uint) public allowance;
    mapping(address => bool) public isAllowedToSend;

    mapping (address => bool) public guardians;
    address payable nextOwner;
    mapping(address => mapping(address => bool)) nextOwnerGuardianVotedBool;
    uint guardiansResetCount;
    uint public constant confirmationsFromGuardiansForReset = 3;

    constructor () {
        walletOwner = payable(msg.sender);
    }

    function setGuardian(address _guardian, bool _isGuardian) public {
        require(msg.sender == walletOwner, "You are not the owner");
        guardians[_guardian]=_isGuardian;
    }

    function proposeNewOwner(address payable _newOwner) public {
        require(guardians[msg.sender], "You are not a guardian of this wallet");
        require(nextOwnerGuardianVotedBool[_newOwner][msg.sender]==false, "You already voted");
        if(_newOwner != nextOwner) {
            nextOwner = _newOwner;
            guardiansResetCount = 0;
        }
        guardiansResetCount ++;

        if(guardiansResetCount >= confirmationsFromGuardiansForReset) {
            walletOwner = nextOwner;
            nextOwner = payable(address(0));
        }
    }

    function setAllowance(address _for, uint _amount) public {
        require(msg.sender == walletOwner, "You are not the owner");
        allowance[_for]=_amount;

        if(_amount >0) {
            isAllowedToSend[_for]=true;
        } else {
            isAllowedToSend[_for] = false;
        }
    }

    function transfer(address payable _to, uint _amount, bytes memory _payload) public returns(bytes memory) {
        require(msg.sender == walletOwner, "You are not the owner");
        if(msg.sender != walletOwner) {
            require(allowance[msg.sender] >= _amount, "You are trying to send more than you are allowed to");
            require(isAllowedToSend[msg.sender], "You are not allowed to send anything from this smart contract");

            allowance[msg.sender]-= _amount;
        }
        (bool success, bytes memory returnData) =  _to.call{value: _amount}(_payload);
        require(success, "Aborting, call was not successful");
        return returnData;
    }

    receive() external payable {}


    fallback() external payable {

    }

}
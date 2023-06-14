//SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

contract ContractOne {
    mapping (address => uint) public addressBalances;

    function deposit() public payable {
        addressBalances[msg.sender] +=msg.value;
    }

    receive() external payable {
        deposit();
    }
}

contract ContractTwo {
    receive() external payable {}

    function depositOnContractOne (address _contractOne) public {
        bytes memory payload = abi.encodeWithSignature("deposit()");
        //ContractOne one = ContractOne(_contractOne);
        //native transfer of funds from contract two to contract one
        //one.deposit{value: 10, gas: 100000}();
       (bool success,) =  _contractOne.call{value: 10, gas: 100000}(payload);
       require(success);
    }
}
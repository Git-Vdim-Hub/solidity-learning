# solidity-learning
Solidity Smart Contracts I wrote during the Ethereum Blockchain Developer Bootcamp


Notes:

View/Pure Function
-earlier called a "constant" function

View Function: Reading from the State and from other View Functions
Pure Function: Not Reading or modifying the state, just the values inside of that function 


public functions: can be called internally and externally
private functions: only for the contract, not externally reachable and not via derived contracts

External functions: can be called from other contracts and can be called externally

Internal functions: only from the contract itself or from derived contracts. Can't be invoked by a transaction

constructor: called only during deployment, cant be called afterwards, is either public or internal, 
can only be one in a contract and is either public or internal.

two most important methods of a contract:
msg.sender (the address that sends the transaction)
msg.value (the amount of eth that was sent within the transaction to the smart contract)
payable modifier (makes the function to allow to recieve eth

Fallback function: is created to receive Ether as a simple transaction
 function with the name fallback () external [payable] to receive calldata or a function with the name
"receive() external payable" to receive a value without calldata. Called when the function in the transaction isnt found
Can only be external fallback payable is optional

Contracts receiving Ether without a fallback function and without a function call will throw an exception
You cannot completely avoid receiving Ether Miner reward or selfdestruct (address) will forcefully credit Ether
Worst case: You can only rely on 2300 gas (gas stipend)
_contractAddress.transfer(1 ether); send only 2300 gas along

Forcefully prevent contract execution if called with contract data
require (msg.data.length == 0 )


Global msg-object contains a value property (in wei)

Address-type variables have a balance (address X = 0x123... X.balance)
Address-type variable can be payable (address payable x)
Payable addresses can receive a value (x.transfer(...wei))
The contract itself can have a balance (address(this).balance)


Mini Project 2: Wallet Smart Contract
-deposit eth
-see balance
-withdraw eth to a specific address


Structs
struct Funder {
 address addr;
 uint amount;
}

Funder _funder;
_funder.addr = 0x123;
_funder.amount = 5000;

-members of struct can be of any type except for a Struct.


Structs and Mappings combined:
struct MyStruct {
 uint var1;
 uint var2;
 }
 mapping(uint => MyStruct) public someVar;

 Enum - one way to create a user-defined type in Solidity (integers internally)
 enum ActionChoices {GoLeft, GoRight, GoStrait, SitStill }
 ActionChoices choice;
 ActionChoices constant defaultChoice = ActionChoices.GoStraight;

 Address-Low Level calls
.send() returns a Boolean, doesn't cascade exceptions
.call{gas: ..., value: ...}() lets you forward a specific amount of gas, also returns a boolean

.send, .transfer both only transfer 2300 gas along
Mini Project 3: The Smart Contract Wallet Implementation
1. Wallet has 1 Owner
2. Receive funds with a fallback function
3. Spend money on Externally Owned Account and Contracts
4. Give Allowance to other people
5. Set a new owner with 3-out-of-5 guardians

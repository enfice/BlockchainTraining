pragma solidity 0.4.23;

contract FunctionModifiers {

    address owner;
    
    // Function Modifier
    // The function body is inserted where the special symbol "_" in the
    // definition of a modifier appears.
    modifier onlyowner {
        if (msg.sender == owner)
            _;
    }

    uint price;
  
    function changePrice(uint _price) public onlyowner {
        price = _price;
    }
}


contract GlobalVariablesAndFunctions {

    // msg represent the current message received by the contracts during the execution. 
    // So when you as a user send a message to contract or make a function call from drop down menu of mist wallet
    // you catually send a message to contract which can be accessed by using msg

    // using msg.sender you can access then address of the sender
    msg.sender;

    // amount of ether provided to this contract in wei can be accessed like this
    msg.value; 

    // complete call data in bytes can be accessed like this
    msg.data; 

    // you can access the remaining gas like this
    msg.gas; 

    // you can return the first four bytes of the call data like this
    msg.sig; 

    // similarly tx represent the current transaction in smart contract

    // you can access address of sender of the transaction like this
    tx.origin; 

    // you can access the gas price of the transaction
    tx.gasprice; 


    
    // now will give you the current time approximately in unix timestamp format
    now; 

    // like msg & tx, block represent the information about the current Block

    block.number; // current block number
    block.difficulty; // current block difficulty
    block.blockhash(1); // returns bytes32, only works for most recent 256 blocks
    block.gasLimit(); //return Gas limit
    block.coinbase (); // return current block miner’s address

    // there are manu athematical and Cryptographic Functions as well 
    // which you can access anywhere in smart contracts
    assert(bool condition); // throws an exception if the condition is not met.
    addmod(uint x, uint y, uint k); // returns (uint);  //compute (x + y) % k where the addition is performed with arbitrary precision and does not wrap around at 2**256.
    mulmod(uint x, uint y, uint k);// returns (uint); // compute (x * y) % k where the multiplication is performed with arbitrary precision and does not wrap around at 2**256.
    keccak256(...); // returns (bytes32); // compute the Ethereum-SHA-3 (Keccak-256) hash of the (tightly packed) arguments
    sha3(...); // returns (bytes32); // alias to keccak256()
    sha256(...); // returns (bytes32) // compute the SHA-256 hash of the (tightly packed) arguments
    ripemd160(...); // returns (bytes20) // compute RIPEMD-160 hash of the (tightly packed) arguments
    ecrecover(bytes32 hash, uint8 v, bytes32 r, bytes32 s); // returns (address) // recover the address associated with the public key from elliptic curve signature or return zero on error
    revert(); // abort execution and revert state changes
    // sha3("ab", "c") == sha3("abc") == sha3(0x616263) == sha3(6382179) = sha3(97, 98, 99)

    // Address Related
    <address>.balance; // returns (uint256); // balance of the Address in Wei
    <address>.send(uint256 amount); // returns (bool); //send given amount of Wei to Address, returns false on failure
    <address>.transfer(uint256 amount); // send given amount of Wei to Address, but throws on failure

    // Contracts Related
    this; // (current contract’s type) the current contract, explicitly convertible to Address
    selfdestruct(address recipient); // destroy the current contract, sending its funds to the given Address



    // Define consutruct here
    function GlobalVariablesAndFunctions(uint initialCoins) {
       // Initialize state variables here
    }

}


contract Units {
    // Ether Units are available as a global variables
    // wei, finney, szabo & ether are variable themself
    // variable can not be named as the ether, finney, szabo, wei 
    bool isEqual = (2 ether == 2000 finney);


    // Time Units are also availabel in solidity like this 
    // seconds, minutes, hours, days, weeks, years are all available at time units to be used
    // can be used anywher in the program like mentioned below
    bool isEqual = (1 == 1 seconds);
    bool isEqual = (1 minutes == 60 seconds);
    bool isEqual = (1 hours == 60 minutes);
    bool isEqual = (1 days == 24 hours);
    bool isEqual = (1 weeks = 7 days);
    bool isEqual = (1 years = 365 days);

    function Units(uint initialCoins) {
       // Initialize state variables here
    }

}


contract EventsExample {
    // Event
    event LogUpdate(address indexed _from, bytes32 indexed _id, uint _value);

    function updateInfo(uint newInfo, bytes32 _id) public {
        kill();
        emit LogUpdate(msg.sender, _id, 3);
        if (msg.sender == owner) info = newInfo;
    }

    uint info;
}

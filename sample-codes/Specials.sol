pragma solidity 0.4.23;

contract FunctionModifiers {

    address owner;

    // Function Modifier
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
    // using msg.sender you can access then address of the sender
    address senderAddress = msg.sender;

    // amount of ether provided to this contract in wei can be accessed like this
    uint givenValue = msg.value;

    bytes givenData = msg.data;
    uint givenGas = msg.gas;

    // the first four bytes of the call data
    bytes givenSig = msg.sig;

    // tx represent the current transaction in smart contract
    // address of sender of the transaction
    address orgAdress = tx.origin;

    //the gas price of the transaction
    uint gasPrice = tx.gasprice;

    // the current time approximately in unix timestamp format
    uint currentTime =  now;

    // block
    int currentBlockNum = block.number; // current block number
    int currentDifficulty = block.difficulty; // current block difficulty
    bytes32 blockHash = block.blockhash(1); // returns bytes32, only works for most recent 256 blocks
    int givenGasLimit = block.gasLimit(); //return Gas limit
    address baseAddress = block.coinbase (); // return current block miner’s address

    // Arithmetical and Cryptographic Functions as well 
    // you can access them anywhere in smart contracts
    assert(bool condition); // throws an exception if the condition is not met.
    addmod(uint x, uint y, uint k); // returns (uint);  //compute (x + y) % k
    mulmod(uint x, uint y, uint k);// returns (uint); // compute (x * y) % k
    keccak256(...); // returns (bytes32); // compute the Ethereum-SHA-3 (Keccak-256) hash
    sha3(...); // returns (bytes32); // alias to keccak256()
    sha256(...); // returns (bytes32) // compute the SHA-256 hash 
    ripemd160(...); // returns (bytes20) // compute RIPEMD-160 hash
    ecrecover(bytes32 hash, uint8 v, bytes32 r, bytes32 s); // returns (address) // recover the address associated with the public key from elliptic curve signature or return zero on error
    revert(); // abort execution and revert state changes

    // Address Related
    <address>.balance; // returns (uint256); // balance of the Address in Wei
    <address>.send(uint256 amount); // returns (bool); //send given amount of Wei to Address, returns false on failure
    <address>.transfer(uint256 amount); // send given amount of Wei to Address, but throws on failure

    // Contracts Related
    this; // (current contract’s type) the current contract, explicitly convertible to Address
    selfdestruct(address recipient); // destroy the current contract, sending its funds to the given Address
}


contract Units {
    // Ether Units are available as a global variables
    // wei, finney, szabo & ether are variable themself
    // variable can not be named as the ether, finney, szabo, wei 
    bool isEqual = (2 ether == 2000 finney);

    bool isEqual = (1 == 1 seconds);
    bool isEqual = (1 minutes == 60 seconds);
    bool isEqual = (1 hours == 60 minutes);
    bool isEqual = (1 days == 24 hours);
    bool isEqual = (1 weeks = 7 days);
    bool isEqual = (1 years = 365 days);

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

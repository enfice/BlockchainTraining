pragma solidity 0.4.23;

contract BaseCoin {
    constructor () public {
        owner = msg.sender;
    }
    address owner;
}

// Use "is" to derive from another contract. Derived contracts can access all members
// including private functions and storage variables.
contract MortalCoin is BaseCoin {
    function kill() public {
        if (msg.sender == owner)
            selfdestruct(owner);
    }
}

// Abstract Contracts
// They only define functions but does not implement them
contract CoinHelper1 {
    function lookup(uint id) public returns (address adr);
}
contract CoinHelper2 {
    function register(bytes32 name) public;
    function unregister() public;
}


// Implementation of CoinHelper1
contract RubyCoin is CoinHelper1 {
    address rubyHolder;
    uint myid = 0;
    function lookup(uint id) public returns (address adr){
        myid = id;
        return rubyHolder;
    }
}

// Implementation of CoinHelper2
contract GemCoin is CoinHelper2 {
    bytes32 myName = "";
    function register(bytes32 name) public {
        myName = name;
    }
    function unregister() public {
        myName = "";
    }
}

// Multiple inheritance is possible. Note that "BaseCoin" is also a base class of
// "MortalCoin", yet there is only a single instance of "BaseCoin" (as for virtual
// inheritance in C++).
contract IornCoin is BaseCoin, MortalCoin {
    address ConfigAddress = 0xd5f9d8d94886e70b06e474c3fb14fd43e2f23970;

    constructor (bytes32 name) public {
        GemCoin(RubyCoin(ConfigAddress).lookup(1)).register(name);
    }

// Functions can be overridden, both local and message-based function calls take
// these overrides into account.
    function kill() public {
        if (msg.sender == owner) {
            GemCoin(RubyCoin(ConfigAddress).lookup(1)).unregister();
            // It is still possible to call a specific overridden function. 
            MortalCoin.kill();
        }
    }
}

// If a constructor takes an argument, it needs to be provided in the header.
contract DiamondCoin is BaseCoin, MortalCoin, IornCoin("GoldFeed") {
    function updateInfo(uint newInfo) public {
        kill();
        if (msg.sender == owner) info = newInfo;
    }

    function get() public view returns(uint r) {
        return info;
    }

    uint info;
}

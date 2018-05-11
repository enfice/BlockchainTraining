pragma solidity 0.4.23;

contract Base {
    constructor () public {
        owner = msg.sender;
    }
    address owner;
}

// Use "is" to derive from another contract. Derived contracts can access all members
// including private functions and storage variables.
contract Mortal is Base {
    function kill() public {
        if (msg.sender == owner)
            selfdestruct(owner);
    }
}

// These are only provided to make the interface known to the compiler.
contract Config {
    function lookup(uint id) public returns (address adr) {}
}
contract NameReg {
    function register(bytes32 name) public {}
    function unregister() public {}
}

// Multiple inheritance is possible. Note that "Base" is also a base class of
// "Mortal", yet there is only a single instance of "Base" (as for virtual
// inheritance in C++).
contract named is Base, Mortal {
    address ConfigAddress = 0xd5f9d8d94886e70b06e474c3fb14fd43e2f23970;

    constructor (bytes32 name) public {
        
        NameReg(Config(ConfigAddress).lookup(1)).register(name);
    }

// Functions can be overridden, both local and message-based function calls take
// these overrides into account.
    function kill() public {
        if (msg.sender == owner) {
            NameReg(Config(ConfigAddress).lookup(1)).unregister();
            // It is still possible to call a specific overridden function. 
            Mortal.kill();
        }
    }
}

// If a constructor takes an argument, it needs to be provided in the header.
contract PriceFeed is Base, Mortal, named("GoldFeed") {
    function updateInfo(uint newInfo) public {
        if (msg.sender == owner) info = newInfo;
    }

    function get() public view returns(uint r) {
        return info;
    }

    uint info;
}
pragma solidity 0.4.23;

contract SimpleCoin {
    address minter;
    address artist;
    uint royality = 5;
    mapping (address => uint) balances;
    
    constructor () public {
        minter = msg.sender;
    }

    function mint(address owner, uint amount) public {
        if (msg.sender != minter) return;
        balances[owner] += amount;
    }

    function send(address receiver, uint amount) public {
        if (balances[msg.sender] < amount) return;
        balances[msg.sender] -= amount + royality;
        balances[artist] += royality;
        balances[receiver] += amount;
    }

    function queryBalance(address addr) public view returns (uint balance)  {
        return balances[addr];
    }

}

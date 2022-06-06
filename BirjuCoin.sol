// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract BirjuCoinERC20 {
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
    string public constant name = "Birju Coin";
    string public constant symbol = "BMAR";
    uint8 public constant decimals = 18;

    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;
    /*
    A mapping in Solidity is similar to a key-value pair. 
    So in the balances, an address is the key while the uint256 (unsigned integer of 256 bits) is the value. 
    */

    uint256 totalSupply_;

    /*
        In smart contracts, the constructor is called when the contract is deployed to the network.
    */
    constructor(uint256 total){
        totalSupply_ = total;
        balances[msg.sender] = totalSupply_;
    }
    // setting the balance of the contract creator to the total supply

    function balanceOf(address tokenOwner) public view returns(uint){
        return balances[tokenOwner];
    }

    function transfer(address reciever, uint numTokens) public returns(bool){
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] -= numTokens;
        balances[reciever] += numTokens;
        emit Transfer(msg.sender, reciever, numTokens);
        return true;
    }

    function approve(address delegate, uint numTokens) public returns(bool) {
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    function allowance(address owner, address delegate) public view returns (uint) {
        return allowed[owner][delegate];
    }

    function transferFrom(address owner, address buyer, uint numTokens) public returns (bool) {
        require(numTokens <= balances[owner]);
        require(numTokens <= allowed[owner][msg.sender]);
        balances[owner] -= numTokens;
        allowed[owner][msg.sender] -= numTokens;
        balances[buyer] += numTokens;
        emit Transfer(owner, buyer, numTokens);
        return true;
    }

    
}

//SPDX-License-Identifier: MIT

pragma solidity 0.8.1;

contract SharedWallet {

    address public owner;

    // MODIFIERS
    modifier onlyOwner() {
        require(msg.sender == owner, "You're not the owner, fool!");
        _;
    }

    constructor() public{
        owner = msg.sender;
    }

    function withdrawMoney(address payable _to, uint _amount) public onlyOwner {
        _to.transfer(_amount);
    }

    // fall back function for when someone sends the contract monies but they fat-finger something
    receive() external payable {

    }
}

//SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

import './Allowance.sol';

contract SharedWallet is Allowance {
    // ******** EVENTS ******** 
    event MoneySent( address indexed _beneficiary, uint _amount );
    event MoneyReceived( address indexed _from, uint _amount );

    // ******** FUNCTIONS ******** 
    function withdrawMoney( address payable _to, uint _amount ) public ownerOrAllowed( _amount ) {
        require( _amount <= address(this).balance, "Contract doesn't own enough money");

        if(!isOwner()) { reduceAllowance(msg.sender, _amount); }

        emit MoneySent( _to, _amount );
        _to.transfer(_amount);
    }

    function renounceOwnership() public override onlyOwner {
        revert("No bueno duderino. You will ALWAYS own this contract!"); // not possible with this smart contract
    }

    // fallback function for when someone sends the contract monies but they fat-finger something
    receive() external payable {
        emit MoneyReceived( msg.sender, msg.value );
    }
}

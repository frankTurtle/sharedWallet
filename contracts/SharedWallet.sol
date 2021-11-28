//SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

import './Allowance.sol';

contract SharedWallet is Allowance {
    function withdrawMoney( address payable _to, uint _amount ) public ownerOrAllowed( _amount ) {
        require( _amount <= address(this).balance, "Contract doesn't own enough money");

        if(!isOwner()) { reduceAllowance(msg.sender, _amount); }

        _to.transfer(_amount);
    }

    // fallback function for when someone sends the contract monies but they fat-finger something
    receive() external payable {

    }
}

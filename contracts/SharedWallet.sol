//SPDX-License-Identifier: MIT

pragma solidity 0.8.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract SharedWallet is Ownable {

    // address public owner; // REMOVED TO USE OPENZEPPELIN CONTRACT INSTEAD

    // REMOVED TO USE OPENZEPPELIN CONTRACT INSTEAD
    // constructor() public{
    //     owner = msg.sender;
    // }

    /**
     * @dev verification if the owner is the owner
     */
    function isOwner() internal view returns(bool) {
        return owner() == msg.sender;
    }

    function withdrawMoney(address payable _to, uint _amount) public onlyOwner {
        _to.transfer(_amount);
    }

    // fall back function for when someone sends the contract monies but they fat-finger something
    receive() external payable {

    }
}

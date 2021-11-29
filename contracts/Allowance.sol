pragma solidity ^0.8.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Allowance is Ownable {
    // ******** STATE VARIABLES ******** 
    mapping( address => uint ) public allowance;

    // ******** EVENTS ******** 
    event AllowanceChanged( address indexed _forWho, address indexed _byWhom, uint _oldAmount, uint _newAmount );

    // address public owner; // REMOVED TO USE OPENZEPPELIN CONTRACT INSTEAD

    // REMOVED TO USE OPENZEPPELIN CONTRACT INSTEAD
    // constructor() public{
    //     owner = msg.sender;
    // }

    // ******** MODIFIERS ******** 
    modifier isOwnerOrAllowed( uint _amount ) {
        require( isOwner() || allowance[msg.sender] >= _amount, "You are not allowed, fool!" );
        _;
    }

    // ******** FUNCTIONS ******** 

    /**
     * 
     */
    function addAllowance( address _who, uint _amount ) public onlyOwner {
        emit AllowanceChanged( _who, msg.sender, allowance[_who], _amount );
        allowance[_who] = _amount;
    }

    /**
     * @dev verification if the owner is the owner
     */
    function isOwner() internal view returns(bool) {
        return owner() == msg.sender;
    }

    function reduceAllowance( address _who, uint _amount ) internal isOwnerOrAllowed( _amount ) {
        emit AllowanceChanged( _who, msg.sender, allowance[_who], allowance[_who] - _amount );
        allowance[_who] -= _amount;
    }
}
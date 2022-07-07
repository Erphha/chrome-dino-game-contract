//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract Ownable{
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor(){
        _owner = msg.sender;
        emit OwnershipTransferred(address(0), _owner);
    }

    function owner() public view returns(address){
        return _owner;
    }

    modifier onlyOwner() {
        require(isOwner());
        _;
    }

    function isOwner() public view returns(bool){
        return msg.sender == _owner;
    }

    function transferOwnership(address newOwner) public onlyOwner{
        _transferOwnership(newOwner);
    }

    function _transferOwnership(address newOwner) internal {
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}
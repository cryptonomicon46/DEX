

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
abstract contract Ownable {

    address private owner;

    constructor() {
        owner = msg.sender;

    }



    function _isOwner(address sender) internal view {
        require(sender== owner,"You're not the owner!");
    }
    modifier onlyBy(address sender) {
        _isOwner(sender);
        _;
    }





}
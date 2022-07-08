
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
abstract contract NoDelegateCall {

    address private originalAddress;

    constructor() {
        originalAddress = address(this);
        // owner = _owner;
    }

    function _noDelegateCall() internal view {
        require(address(this)== originalAddress, "Delegate Call");
    }

    modifier noDelegateCall() {
       _noDelegateCall();
        _;

    }

    

}
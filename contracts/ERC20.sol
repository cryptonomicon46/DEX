//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import './MySwapERC20.sol';
import './NoDelegateCall.sol';
import './Ownable.sol';


contract ERC20 is  MySwapERC20, Ownable,NoDelegateCall{
    address private owner;
    address private originalAddress;
constructor (uint initialSupply) {
    _mint(msg.sender, initialSupply);
    owner = msg.sender;
    originalAddress = address(this);

}

function balances(address sender) external view returns (uint) {
    return balanceOf[sender];
}


function mint(address to, uint amount)  public  onlyBy(owner) {
    require(amount < totalSupply,"Amount exceeds total supply");
    _mint(to, amount);

}

function burn(address from, uint amount) public onlyBy(owner)  {
    require(balanceOf[from]>= amount,"Insufficient balance to burn");
    _burn(from, amount);

}

    // function getOriginalAddr() public returns (address) {
    //     return  originalAddress;
        
    // }

}
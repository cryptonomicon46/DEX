//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import './interfaces/IMySwapERC20.sol';
import './libraries/SafeMath.sol';

contract MySwapERC20 is IMySwapERC20 {
    using SafeMath for uint256;
    string public constant name ="MYDex-ERC20";
    string public constant symbol ="MDE20";
    uint public immutable decimals = 18;
    uint public totalSupply;
    mapping  (address => uint) public balanceOf;
    mapping (address=> mapping(address=> uint)) public allowance;


    function _transfer(address owner,address to, uint amount) internal {
        balanceOf[owner] =  balanceOf[owner].sub(amount);
        balanceOf[to] = balanceOf[to].add(amount);
        emit Transfer(msg.sender, to, amount);
    }

    function transfer(address to, uint amount) external returns (bool) {
        require(to != address(0));
        require(balanceOf[msg.sender]> amount,"Insufficient Balance!");
        _transfer(msg.sender, to, amount);
        return true;
    }

    function transferFrom(address from, address to, uint amount) external returns (bool) {
        require(allowance[from][msg.sender]>=amount);
        allowance[from][msg.sender] = allowance[from][msg.sender].sub(amount);
        _transfer(from, to ,amount);
        return true;
    }

    function _approve(address owner, address spender, uint amount) internal {
        allowance[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function approve(address spender, uint amount) external returns (bool) {
        _approve(msg.sender,spender,amount);
        return true;
    }


    function _mint(address to, uint amount) internal {
        totalSupply = totalSupply.add(amount);
        balanceOf[to] = balanceOf[to].add(amount);
        emit Transfer(address(0),to,amount);
    }


    function _burn(address from, uint amount) internal {
        require(balanceOf[from]>amount,"Insufficient Balance");
        totalSupply = totalSupply.sub(amount);
        balanceOf[from] = balanceOf[from].sub(amount);
        emit Transfer(from, address(0), amount);
    }




}

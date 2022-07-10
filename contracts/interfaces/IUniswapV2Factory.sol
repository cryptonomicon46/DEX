//SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

interface IUniswapV2Factory{
    event PoolCreated(address indexed token0, address indexed token1, address poolAddr);
    

    function createPool(address TokenA, address TokenB) external  returns (address);




}
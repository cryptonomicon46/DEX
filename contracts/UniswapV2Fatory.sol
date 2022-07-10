//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import './NoDelegateCall.sol';
import './Ownable.sol';
import './interfaces/IUniswapV2Factory.sol';
import './UniswapV2Pair.sol';


contract UniswapV2Factory is  IUniswapV2Factory, NoDelegateCall, Ownable {


    address private poolAddress;

    address private pool;

    mapping (address => mapping(address=> address)) getPool;

    constructor ()  {

    }    


    function createPool(address TokenA, address TokenB) external noDelegateCall  returns (address) {
        require(TokenA != address(0) && TokenB != address(0),"Invalid token addresses");
        (address token0, address token1) = TokenA> TokenB?  (TokenA, TokenB):(TokenB, TokenA);
        require( getPool[token0][token1] == address(0),"Pool already exists");

        pool = address (new UniswapV2Pair{salt: keccak256(abi.encode(address(this), token0, token1))}());
        getPool[token0][token1] = pool;

        UniswapV2Pair(pool).initialize((token0), token1);
        emit PoolCreated(token0, token1, getPool[token0][token1]);
        return getPool[token0][token1];
    }

    


}
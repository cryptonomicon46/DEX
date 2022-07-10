//SPDX-License-Identifier

pragma solidity ^0.8.10;


contract UniswapV2Pair {
        address public  factory;
        address public  token0;
        address public  token1;
        constructor(){
            factory = msg.sender;

        }



        function initialize(address _token0, address _token1) external  {
            token0 = _token0;
            token1 = _token1;

        }

}

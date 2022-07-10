To  Install and run this project. Please use the following scripts

npm install
npx hardhat accounts
npx hardhat clean
npx hardhat compile

npx hardhat test
npx hardhat node
node scripts/sample-script.js
npx hardhat help
```


Project goals:
In this project we'll replicate the functionality of the UNITSWAP V2 contracts. 
Implement our own version of the ERC20 contract. 

The user should be able to deposit an ERC20 token and be able to swap to the desired token. 
Allow the fees to be distributed into the pool to increase the k balance. 


Allow for Staking, give our LP tokens in exchange for staking. 
Accumulate rewards. 

Allow for lending and charge an interest rate APR.

Allow for flash loans. 


You'll find implementations of the following contracts:

ERC20 CONTRACT
    -MySwapERC20 (interface and contract)
    -ERC20 that inherits from MySwapERC20
    -Tests for the ERC20 contract. 


POOL CONTRACT

FACTORY CONTRACT

ROUTER CONTRACT


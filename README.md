# upgradable_smart_contract-ERC20-token

Upgradable features for smart contracts without “delegate calls”, which could be obsolete in
case of transaction with higher gas limit.

**Deploy and Run** 

first run 
>$ truffle migrate

later 
>$ truffle migrate --reset

TestToken is the contract with upgradable facility. 

**To upgrade**

>$ truffle migrate -f 3 

*Note: 3 is the migration for TestToken, 2 deployes the eternal storage part.*

pragma solidity ^0.4.18;

contract tokenStorage {

    mapping(address => uint) balances;
    mapping(address => mapping (address => uint256)) allowances;

    mapping(address => bool) accessAllowed;

    constructor() public {
        accessAllowed[msg.sender] = true;
        balances[msg.sender] = 10000;
    }

    modifier platform() {
        require(accessAllowed[msg.sender] == true);
        _;
    }

    function allowAccess(address _address) platform public {
        accessAllowed[_address] = true;
    }

    function denyAccess(address _address) platform public {
        accessAllowed[_address] = false;
    }


    function getBalance(address _address) public view returns(uint256) {
        return balances[_address];
    }

    function setBalance(address _address, uint _balance) platform public {
        balances[_address] = _balance;
    }

    function getAllowance(address _owner, address _spender) public view returns(uint256){
        return allowances[_owner][_spender];
    }

    function setAllowance(address _owner, address _spender, uint256 _value) platform public{
        allowances[_owner][_spender] = _value;

    }



}










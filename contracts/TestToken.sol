pragma solidity ^0.4.20;

import "./tokenStorage.sol";

contract TestToken {

	tokenStorage storageContract;

	address public admin;

	function admined() public{
		admin = msg.sender;
	}

	modifier onlyAdmin{
		require(msg.sender == admin);
		_;
	}

	function transferAuthority(address newAdmin) onlyAdmin public{
		admin = newAdmin;
	}


/* token - Actual ERC20 implementatation */

	// token info and the details 
	string public name = "Test Token";
	string public symbol = "TT";
	uint256 public decimals = 18;
	uint256 public totalSupply;

	event Transfer(address indexed _from, address indexed _to, uint256 _value);
	event Approval(address indexed _owner, address indexed _spender, uint256 _value);
	
	/* mapping (address => uint256) public balanceOf;
	mapping (address => mapping (address => uint256)) public allowance; */ 
	
	
	/* constructor(uint256 _initialSupply) public{
		balanceOf[msg.sender] = _initialSupply;
		totalSupply = _initialSupply;
	} */

	constructor(address _storageContractAddress){
		storageContract = tokenStorage(_storageContractAddress);
	}

	function _transfer(address _from, address _to, uint256 _value) internal{
		
		require (_to != 0x0);

		require(storageContract.getBalance(_from) >= _value);
		storageContract.setBalance(_from, storageContract.getBalance(_from) - _value);
		storageContract.setBalance(_to, storageContract.getBalance(_to) + _value);

		emit Transfer(_from, _to, _value);	
	}

	// transfer function as described in the ERC20 standards 
	function transfer(address _to, uint256 _value) public returns(bool success){
		_transfer(msg.sender, _to, _value);
		return true;
	}

	function approve(address _spender, uint256 _value) public returns(bool success){
		storageContract.setAllowance(msg.sender, _spender, _value);
		//allowance[msg.sender][_spender] = _value;	
		emit Approval(msg.sender, _spender, _value);
		return true;
	}

	function transferFrom(address _from, address _to, uint256 _value) public returns(bool success){
		// there were lines here before from the early development, but they have been taken out
		//require(_value <= allowance[_from][msg.sender]);     // Check allowance
        //allowance[_from][msg.sender] -= _value;

        require(_value <= storageContract.getAllowance(_from, msg.sender));
        storageContract.setAllowance(_from, _to, storageContract.getAllowance(_from, _to) - _value);        
        _transfer(_from, _to, _value);
        return true;
	} 			

	function balanceOf(address addr) public view returns(uint) {
		return storageContract.getBalance(addr) + 10; //this is the bug which can be replaced when needed.
	}

	function allowanceOf(address _owner, address _spender) public view returns(uint) {
		return storageContract.getAllowance(_owner, _spender) + 100; //this is the bug which can be replaced when needed.
	}

	
	function kill() onlyAdmin public{
		selfdestruct(admin);
	}


}



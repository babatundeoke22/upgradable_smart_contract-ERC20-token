var TestToken = artifacts.require("./TestToken.sol");
var tokenStorage = artifacts.require("./tokenStorage.sol");

module.exports = function(deployer) {
  deployer.deploy(TestToken, tokenStorage.address).
  then(() => {
  	tokenStorage.deployed().then(i => {
  		return i.allowAccess(TestToken.address);
  	});
  });
};

/*var ConvertLib = artifacts.require("./ConvertLib.sol");
var MetaCoin = artifacts.require("./MetaCoin.sol");
var MetaCoinStorage = artifacts.require("./MetaCoinStorage.sol");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, MetaCoin);
  deployer.deploy(MetaCoin, MetaCoinStorage.address).
  then(() => {
  	MetaCoinStorage.deployed().then(inst => {
  		return inst.allowAccess(MetaCoin.address);
  	});
  });
};*/

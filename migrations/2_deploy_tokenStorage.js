var tokenStorage = artifacts.require("./tokenStorage.sol");

module.exports = function(deployer) {
  deployer.deploy(tokenStorage);
};


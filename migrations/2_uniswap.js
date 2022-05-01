const Migrations = artifacts.require("./Uniswap.sol");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};

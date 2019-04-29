var UpikoApp = artifacts.require("./UpikoApp.sol");

module.exports = function(deployer, network) {
  if (network === 'rinkeby') {
    return
  }

  deployer.deploy(UpikoApp);
};

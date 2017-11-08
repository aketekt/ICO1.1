const SouthernBlocksCoinCrowdsale = artifacts.require("./SouthernBlocksCoinCrowdsale.sol")

module.exports = function(deployer, network, accounts) {
  const startTime = 1510117050 // 24hours / 86400 seconds in the future
  const endTime = startTime + (86400 * 7) // 7 days
  const initialRate = new web3.BigNumber(1000)
  const wallet = "0x46478cCda4d33f45C3f99502D0632372A22fD081" 

  deployer.deploy(SouthernBlocksCoinCrowdsale, startTime, endTime, initialRate, wallet)
};
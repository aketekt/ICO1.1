const SouthernBlocksCoinCrowdsale = artifacts.require("./SouthernBlocksCoinCrowdsale.sol")

module.exports = function(deployer, network, accounts) {
  const startTime = 1510130450 // timestamp
  const endTime = startTime + (86400 * 1) // 7 days
  const initialRate = new web3.BigNumber(1000)
  const discount = new web3.BigNumber(50)
  const discountTime = new web3.BigNumber(200)
  const wallet = "0x46478cCda4d33f45C3f99502D0632372A22fD081" 

  deployer.deploy(SouthernBlocksCoinCrowdsale, startTime, endTime, initialRate, discount, discountTime,  wallet)
};
const SouthernBlocksCoinCrowdsale = artifacts.require("./SouthernBlocksCoinCrowdsale.sol")

module.exports = function(deployer, network, accounts) {
  const startTime = web3.eth.getBlock(web3.eth.blockNumber).timestamp + 86400 // 30 seconds in the future
  const endTime = startTime + (86400 * 3) // 7 days
  const initialRate = new web3.BigNumber(1000)
  const endRate = new web3.BigNumber(850)
  const wallet = "0x46478cCda4d33f45C3f99502D0632372A22fD081" 

  deployer.deploy(SouthernBlocksCoinCrowdsale, startTime, endTime, initialRate, endRate, wallet)
};
const SouthernBlocksCoinCrowdsale = artifacts.require("./SouthernBlocksCoinCrowdsale.sol")

module.exports = function(deployer, network, accounts) {
  const startTime = web3.eth.getBlock(web3.eth.blockNumber).timestamp + 30 // 30 seconds in the future
  const endTime = startTime + (86400 * 7) // 7 days
  const initialRate = new web3.BigNumber(1000)
  const endRate = new web3.BigNumber(1)
  const wallet = accounts[0] 

  deployer.deploy(SouthernBlocksCoinCrowdsale, startTime, endTime, initialRate, endRate, wallet)
};
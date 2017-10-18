const SouthernBlocksCoinCrowdsale = artifacts.require("./SouthernBlocksCoinCrowdsale.sol")

module.exports = function(deployer, network, accounts) {
  const startTime = web3.eth.getBlock(web3.eth.blockNumber).timestamp + 30 // one second in the future
  const endTime = startTime + (86400 * 20) // 20 days
  const intialRate = new web3.BigNumber(1000)
  const endRate = new web3.BigNumber(500)
  const wallet = accounts[0]
 

  deployer.deploy(SouthernBlocksCoinCrowdsale, startTime, endTime, intialRate, endRate, wallet)
};
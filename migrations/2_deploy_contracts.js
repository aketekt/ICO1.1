const SouthernBlocksCoinCrowdsale = artifacts.require("./SouthernBlocksCoinCrowdsale.sol")

module.exports = function(deployer, network, accounts) {

  const startTime = web3.eth.getBlock(web3.eth.blockNumber).timestamp + 60 // 30 seconds in the future
  const endTime = startTime + (300 * 1) // 7 days
  const initialRate = new web3.BigNumber(1000)
  const discount = new web3.BigNumber(50)
  const discountTime = new web3.BigNumber(30)
  const goal = 19500000000000000000000000000000
  const wallet = accounts[0]

  deployer.deploy(SouthernBlocksCoinCrowdsale,startTime, endTime, initialRate, discount, discountTime, goal, wallet)
};
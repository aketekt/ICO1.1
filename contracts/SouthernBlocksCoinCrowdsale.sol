pragma solidity ^0.4.15;

import "zeppelin-solidity/contracts/crowdsale/Crowdsale.sol";
import "./SouthernBlocksCoin.sol";


contract SouthernBlocksCoinCrowdsale is Crowdsale {
    
    //initial rate at which tokens are offered
    uint256 public initialRate;

    //end rate at which tokens are offered
    uint256 public endRate;

    //block at start and end of contract
    uint256 public startBlock = block.number;
    uint256 public endBlock = startBlock + 14500;

    function SouthernBlocksCoinCrowdsale(
        uint256 _startTime,
        uint256 _endTime,
        uint256 _initialRate,
        uint256 _endRate,
        address _wallet
    )
    Crowdsale(_startTime, _endTime, _initialRate, _wallet) 
    {
        require(_initialRate > 0);
        require(_endRate > 0);

        initialRate = _initialRate;
        endRate = _endRate;
    }
    function createTokenContract() internal returns(MintableToken) {
        return new SouthernBlocksCoin();
    }

    //get the token rate based on the current block
    function getRate() internal returns(uint256) {

        uint256 elapsed = block.number - startBlock;
        uint256 rateRange = initialRate - endRate;
        uint256 blockRange = endBlock - startBlock;

        return initialRate.sub(rateRange.mul(elapsed).div(blockRange));
    }

    // low level token purchase function
    function buyTokens(address beneficiary) payable {
        require(beneficiary != 0x0);
        require(validPurchase());

        uint256 weiAmount = msg.value;

        //Calculated rate
        uint256 rate = getRate();

        // calculate token amount to be created
        uint256 tokens = weiAmount.mul(rate);

        // update state
        weiRaised = weiRaised.add(weiAmount);

        //mint token
        token.mint(beneficiary, tokens);

        forwardFunds();
    }
}
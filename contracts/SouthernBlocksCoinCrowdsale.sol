pragma solidity ^0.4.15;

import "zeppelin-solidity/contracts/crowdsale/Crowdsale.sol";
import "./SouthernBlocksCoin.sol";

contract SouthernBlocksCoinCrowdsale is Crowdsale {
    
    uint256 public initialRate;

    function SouthernBlocksCoinCrowdsale(
        uint256 _startTime,
        uint256 _endTime,
        uint256 _initialRate,
        address _wallet
    )
    Crowdsale(_startTime, _endTime, _initialRate, _wallet) 
    {
        require(_initialRate > 0);
        initialRate = _initialRate;
        startTime = _startTime;
    }
    function createTokenContract() internal returns(MintableToken) {
        return new SouthernBlocksCoin();
    }

    //get the token rate based on the current block
    function getRate() internal returns(uint256) {

            uint256 daysElapsed = (now.sub(startTime)).div(86400);
            uint priceIncrease = daysElapsed.mul(50);
            uint newRate = rate.sub(priceIncrease);

            return newRate;
    }
   
    // low level token purchase function
    function buyTokens(address beneficiary) payable {
        require(beneficiary != 0x0);
        require(validPurchase());

        uint256 weiAmount = msg.value;
        uint256 rate = getRate();
        uint256 tokens = weiAmount.mul(rate);

        weiRaised = weiRaised.add(weiAmount);
        token.mint(beneficiary, tokens);

        forwardFunds();
    }
}
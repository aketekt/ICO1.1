pragma solidity ^0.4.15;

import "zeppelin-solidity/contracts/crowdsale/Crowdsale.sol";
import "./SouthernBlocksCoin.sol";

contract SouthernBlocksCoinCrowdsale is Crowdsale {
    
    uint256 public initialRate;
    uint256 public discount;
    uint256 public discountTime;

    function SouthernBlocksCoinCrowdsale(
        uint256 _startTime,
        uint256 _endTime,
        uint256 _initialRate,
        uint256 _discount,
        uint256 _discountTime,
        address _wallet
    )
    Crowdsale(_startTime, _endTime, _initialRate, _wallet) 
    {
        require(_initialRate > 0);
        initialRate = _initialRate;
        discount = _discount;
        discountTime = _discountTime;
        startTime = _startTime;
    }
    function createTokenContract() internal returns(MintableToken) {
        return new SouthernBlocksCoin();
    }

    //get the token rate based on the current block
    function getRate() internal returns(uint256) {

            uint256 daysElapsed = (now.sub(startTime)).div(discountTime);
            uint priceIncrease = daysElapsed.mul(discount);
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
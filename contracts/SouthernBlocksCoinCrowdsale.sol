pragma solidity ^0.4.15;

import "zeppelin-solidity/contracts/crowdsale/Crowdsale.sol";
import "./SouthernBlocksCoin.sol";



contract SouthernBlocksCoinCrowdsale is Crowdsale {
    
    // initial rate at which tokens are offered
    uint256 public initialRate;
    // end rate at which tokens are offered
    uint256 public endRate;

    event InitialRateChange(uint256 rate);
    event EndRateChange(uint256 rate);

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

    function setInitialRate(uint256 rate) public {
        require(rate != 0);
        require(block.number < startTime);

        initialRate = rate;

        InitialRateChange(rate);
    }

    function setEndRate(uint256 rate) public {
        require(rate != 0);
        require(block.number < startTime);

        endRate = rate;

        EndRateChange(rate);
    }

    function getRate() internal returns(uint256) {
     
        uint256 elapsed = block.number - startTime;
        uint256 rateRange = initialRate - endRate;
        uint256 blockRange = endTime - startTime;

        return initialRate.sub(rateRange.mul(elapsed).div(blockRange));
    }
}
pragma solidity ^0.4.11;

import "zeppelin-solidity/contracts/crowdsale/Crowdsale.sol";
import "./SouthernBlocksCoin.sol";

contract SouthernBlocksCoinCrowdsale is Crowdsale {
    

    // customize the rate for each whitelisted buyer
    mapping (address => uint256) public buyerRate;

    // intial rate at which tokens are offered
    uint256 public intialRate;

    // end rate at which tokens are offered
    uint256 public endRate;

    // continuous crowdsale contract
   
    event WalletChange(address wallet);

    event intialRateChange(uint256 rate);

    event EndRateChange(uint256 rate);

    function SouthernBlocksCoinCrowdsale(
        uint256 _startTime,
        uint256 _endTime,
        uint256 _intialRate,
        uint256 _endRate,
        address _wallet
    )
     
        Crowdsale(_startTime, _endTime, _intialRate, _wallet)
    {
        require(_intialRate > 0);
        require(_endRate > 0);

        intialRate = _intialRate;
        endRate = _endRate;
    }

    function createTokenContract() internal returns(MintableToken) {
        return new SouthernBlocksCoin();
    }


    function setBuyerRate(address buyer, uint256 rate) public {
        require(rate != 0);
        require(block.number < startTime);

        buyerRate[buyer] = rate;
    }

    function setintialRate(uint256 rate) public {
        require(rate != 0);
        require(block.number < startTime);

        intialRate = rate;

        intialRateChange(rate);
    }

    function setEndRate(uint256 rate) public {
        require(rate != 0);
        require(block.number < startTime);

        endRate = rate;

        EndRateChange(rate);
    }

    function getRate() internal returns(uint256) {
        // some early buyers are offered a discount on the crowdsale price
        if (buyerRate[msg.sender] != 0) {
            return buyerRate[msg.sender];
        }

        // otherwise compute the price for the auction
        uint256 elapsed = block.number - startTime;
        uint256 rateRange = intialRate - endRate;
        uint256 blockRange = endTime - startTime;

        return intialRate.sub(rateRange.mul(elapsed).div(blockRange));
    }

    // low level token purchase function
    function buyTokens(address beneficiary) payable {
        require(beneficiary != 0x0);
        require(validPurchase());

        uint256 weiAmount = msg.value;
        uint256 updatedWeiRaised = weiRaised.add(weiAmount);

        uint256 rate = getRate();
    }


}
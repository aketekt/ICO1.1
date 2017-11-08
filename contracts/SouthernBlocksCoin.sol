pragma solidity ^0.4.15;

import 'zeppelin-solidity/contracts/token/MintableToken.sol';

contract SouthernBlocksCoin is MintableToken {
  string public name = "LondonCoin";
  string public symbol = "LCC";
  uint256 public decimals = 18;
}
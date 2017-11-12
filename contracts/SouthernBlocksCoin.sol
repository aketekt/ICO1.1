pragma solidity ^0.4.15;

import 'zeppelin-solidity/contracts/token/MintableToken.sol';

contract SouthernBlocksCoin is MintableToken {
  string public name = "TESTLL";
  string public symbol = "LCL";
  uint256 public decimals = 18;
}
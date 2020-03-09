pragma solidity ^0.5.0;

import "./SharedObjectsLibrary.sol";

contract ExchangeRFT {
  uint public exCount = 0;
  
  struct Exchange {
    uint transferId;
    address from;
    address to;
    SharedObjectsLibrary.RFT[] set;
    bool isValid;
  } mapping(string => Exchange) private exchanges;
  
}
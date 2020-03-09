pragma experimental ABIEncoderV2;
pragma solidity ^0.5.0;

import "./SharedObjectsLibrary.sol";
import "./RFTagsCollection.sol";
import "./TrustScoresCollection.sol";

contract ExchangeRFT {
  uint public exCount = 0;
  address rft_address = 0x804F1021aBecc8453Ea6B13045998799503aD5d3;
  address ts_address = 0xC74C15333F64F2B0235Fe580206DD7e579a6cE56;
  RFTagsCollection rftcontract = RFTagsCollection(rft_address);
  TrustScoresCollection tsContract = TrustScoresCollection(ts_address);
  
  struct Exchange {
    uint transferId;
    address from;
    address to;
    string[] set;
    string status;
  } mapping(uint => Exchange) public exchanges;
 
  function beginTransfer(address _from, address _to, string[] memory _set)
  public returns (uint transferId) {
    exCount++;
    Exchange memory _exchanges;
    if(tsContract.getCurrentScore(_to) > 70) {
      for(uint i=0;i<_set.length;i++)
        if(msg.sender==rftcontract.getCurrentOwner(_set[i])) {
          _exchanges.transferId = exCount;
          _exchanges.to = _to;
          _exchanges.set = _set;
          _exchanges.status = "SENT";
          exchanges[exCount] = _exchanges;
        }
    }
    return exCount;
  }
  

  
}
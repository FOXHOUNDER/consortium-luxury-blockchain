pragma experimental ABIEncoderV2;
pragma solidity ^0.5.0;

import "./SharedObjectsLibrary.sol";
import "./RFTagsCollection.sol";
import "./TrustScoresCollection.sol";

contract ExchangeRFT {
  uint public exCount = 0;
  
  RFTagsCollection rftContract;
  TrustScoresCollection tsContract;

  constructor(RFTagsCollection _rftAddress, TrustScoresCollection _tsAddress) public {
    rftContract = _rftAddress;
    tsContract = _tsAddress;
  }

  struct Exchange {
    uint transferId;
    address from;
    address to;
    string[] set;
    string status;
  } mapping(uint => Exchange) public exchanges;
 
  function beginTransfer(address _to, string[] memory _set)
  public returns (uint transferId) {
    exCount++;
    Exchange memory _exchanges;
    if(tsContract.getCurrentScore(_to) > 70) {
      for(uint i=0;i<_set.length;i++)
        if(msg.sender==rftContract.getCurrentOwner(_set[i])) {
          _exchanges.transferId = exCount;
          _exchanges.from = msg.sender;
          _exchanges.to = _to;
          _exchanges.set = _set;
          _exchanges.status = "SENT";
          exchanges[exCount] = _exchanges;
          //rftContract.updateOwner(_set[0], _to);
        }
    }
    return exCount;
  }

  function closeTransfer(uint _transferId, string[] memory _set) 
  public {
    bool exists=false;
    for(uint i=0; i<exchanges[_transferId].set.length; i++) {
      exists=false;
      for(uint j=0; j<_set.length; j++)
        if(keccak256(abi.encodePacked(_set[j])) == keccak256(abi.encodePacked(exchanges[_transferId].set[i]))) {
          exists = true;
          emit WarningRFT(msg.sender, exchanges[_transferId].from, _transferId, _set[j], "The RFT has been received"); }
      if(!exists)
        emit WarningRFT(msg.sender, exchanges[_transferId].from, _transferId, exchanges[_transferId].set[i], "The RFT seems lost");
    } 
  }
  
  event WarningRFT(address receiver, address sender, uint transferId, string uuid, string message);
  

  
}
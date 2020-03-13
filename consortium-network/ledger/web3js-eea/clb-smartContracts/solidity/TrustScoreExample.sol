pragma solidity ^0.5.0;

import "./TrustScoresCollection.sol";

contract TrustScoreExample {
  function get(address _contract, address _par)
  public view returns (uint) {
    return TrustScoresCollection(_contract).getCurrentScore(_par);
  }
  
  function set(address _contract, address _par, uint _score, string memory _report)
  public {
      TrustScoresCollection(_contract).update(_par, _report, _score);
  }
}
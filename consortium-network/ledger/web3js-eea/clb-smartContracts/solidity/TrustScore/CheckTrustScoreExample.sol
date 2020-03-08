pragma solidity ^0.5.0;

import "./TrustScoresCollection.sol";

contract CheckTrustscoreExample {
    function get(address _contract, address _par) public view returns (uint) {
    return TrustScoresCollection(_contract).getCurrentScore(_par);
    }
}
pragma solidity ^0.5.0;

import "./UpdateTrustScore.sol";

contract CheckTrustscore {
    function get(address _ts, uint _id) public view returns (uint) {
    return UpdateTrustScore(_ts).getTS(_id);
    }
}
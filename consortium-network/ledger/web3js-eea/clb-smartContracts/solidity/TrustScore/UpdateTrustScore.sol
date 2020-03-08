pragma solidity ^0.5.0;

contract UpdateTrustScore {
    uint public tsCount = 0;
    address private owner;

    constructor() public { owner = msg.sender; }

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only the Control Agency can perform this operation."
        );
        _;
    }

    struct TrustScore {
        uint id;
        uint score;
        address from_par;
        address to_par;
        string reason;
    } mapping(uint => TrustScore) public trustscores;

    function createTS(address _par) public onlyOwner {
        tsCount ++;
        trustscores[tsCount] = TrustScore(tsCount, 50, owner, _par, "initialization");
        emit TSCreated(tsCount, 50, owner, _par, "initialization");
    }


    function updateTS(uint _id, address _par, string memory _reason, uint _score) public onlyOwner {
        TrustScore memory _trustscore = trustscores[_id];
        _trustscore.score = _score;
        _trustscore.reason = _reason;
        _trustscore.from_par = owner;
        _trustscore.to_par = _par;
        trustscores[_id] = _trustscore;
        emit TSUpdated(_id, _score, _par, _reason);
    }

    function getTS(uint _id) public view returns (uint) {
        return trustscores[_id].score;
    }

    event TSCreated (
        uint id,
        uint score,
        address from_par,
        address to_par,
        string reason
    );

    event TSUpdated (
        uint id,
        uint score,
        address to_par,
        string reason
    );

}
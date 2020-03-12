pragma solidity ^0.5.0;

contract TrustScoresCollection {
  uint public tsCount = 0;
  address private contractOwner;

  constructor() public { contractOwner = msg.sender; }

  modifier onlyContractOwner() {
    require(
      msg.sender == contractOwner,
      "Only the Control Agency can perform this operation."
    );
    _;
  }

  struct TrustScore {
    address participant;
    uint currentScore;
    uint[] allScores;
    string latestReport;
    uint scoresCount;
  } mapping(address => TrustScore) private trustscores;

  function create(address _par)
  public onlyContractOwner {
    tsCount ++;
    TrustScore memory _trustscore;
    uint[] memory _scores = new uint[](1);
    _scores[0] = 50;
    _trustscore.participant = _par;
    _trustscore.currentScore = 50;
    _trustscore.allScores = _scores;
    _trustscore.latestReport = "Initialization";
    _trustscore.scoresCount = 1;
    trustscores[_par] = _trustscore;
    emit GenerateNewTrustScore(_par, 50);
  }

  function update(address _par, string memory _report, uint _score)
  public onlyContractOwner {
    tsCount++;
    TrustScore memory _trustscore = trustscores[_par];
    uint newScoresCount = _trustscore.scoresCount + 1;
    uint[] memory _allScores = new uint[](newScoresCount);
    _trustscore.currentScore = _score;
    
    for(uint i=0;i<newScoresCount-1;i++)
      _allScores[i] = _trustscore.allScores[i];
    _allScores[newScoresCount-1] = _score;
    
    _trustscore.allScores = _allScores;
    _trustscore.latestReport = _report;
    _trustscore.scoresCount = newScoresCount;
    trustscores[_par] = _trustscore;
    emit UpdateTrustScore(_par, _score, _report);
  }

  function getCurrentScore(address _par)
  public view returns (uint) {
    return trustscores[_par].currentScore;
  }

  function getScoresHistory (address _par) 
  public view returns (uint[] memory) {
    return trustscores[_par].allScores;
  }

  event GenerateNewTrustScore (address participant, uint currentScore);
  event UpdateTrustScore (address participant, uint currentScore, string report);

}
pragma solidity ^0.5.0;

contract RfidTagsCollection {
  uint public rftsCount = 0;
  address private contractOwner;

  constructor() public { contractOwner = msg.sender; }

  modifier onlyOwner() {
    require(
      msg.sender == contractOwner,
      "Only the owner of this contract (RFID supplier) can generate new UUIDs."
    );
    _;
  }

  modifier onlyBrand(address _brand) {
    require(
      msg.sender == _brand,
      "A brand owner can mark as invalid only its own UUIDs."
    );
    _;
  }

  struct RFT {
    string uuid;
    uint progressiveId;
    address brand;
    address currentOwner;
    bool isValid;
  } mapping(string => RFT) public rfts;

  function createRFT(string memory _uuid, address _brand)
  public onlyOwner {
    rftsCount ++;
    rfts[_uuid] = RFT(_uuid, rftsCount, _brand, _brand, true);
    emit NewRFT(contractOwner, _uuid, _brand, true);
  }

  function markInvalid(string memory _uuid, address _brand)
  public onlyBrand(_brand) {
    RFT memory _rft = rfts[_uuid];
    _rft.isValid = !_rft.isValid;
    rfts[_uuid] = _rft;
    emit RFTInvalid(_uuid, _rft.isValid);
  }

  event NewRFT(
    address contractOwner,
    string uuid,
    address brand,
    bool isValid
  );

  event RFTInvalid(
    string uuid,
    bool isValid
  );
}
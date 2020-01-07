pragma solidity ^0.5.0;

contract RFIDGenesis {
  uint public rfidCount = 0;
  address private owner;

  constructor() public { owner = msg.sender; }

  modifier onlyOwner() {
    require(
      msg.sender == owner,
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

  struct RFID {
    uint id;
    address owner;
    address brand;
    string code;
    bool valid;
  } mapping(uint => RFID) public rfids;

  function createRFID(string memory _code, address _brand) public onlyOwner {
    rfidCount ++;
    rfids[rfidCount] = RFID(rfidCount, owner, _brand, _code, true);
    emit RFIDCreated(rfidCount, owner, _brand, _code, true);
  }

  function markInvalid(uint _id, address _brand) public onlyBrand(_brand) {
    if(rfids[_id].brand == _brand) {
      RFID memory _rfid = rfids[_id];
      _rfid.valid = !_rfid.valid;
      rfids[_id] = _rfid;
      emit RFIDInvalid(_id, _rfid.valid);
    }
  }

  event RFIDCreated(
    uint id,
    address owner,
    address brand,
    string code,
    bool valid
  );

  event RFIDInvalid(
    uint id,
    bool valid
  );
}
pragma solidity ^0.5.0;

import "./SharedObjectsLibrary.sol";

contract RFTagsCollection {
  uint public tagCount = 0;
  address private contractOwner;

  constructor() public { contractOwner = msg.sender; }

  modifier onlyContractOwner() {
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

  mapping(string => SharedObjectsLibrary.RFT) private rfts;

  function create(string memory _uuid, address _brand)
  public onlyContractOwner {
    tagCount++;
    SharedObjectsLibrary.RFT memory _rft;
    address[] memory _owners = new address[](2);
    _owners[0] = contractOwner;
    _owners[1] = _brand;
    _rft.uuid = _uuid;
    _rft.exchanges = 1;
    _rft.brand = _brand;
    _rft.owners = _owners;
    _rft.currentOwner = _brand;
    _rft.isValid = true;
    rfts[_uuid] = _rft;
    emit GenerateNewTag(contractOwner, _uuid, _brand, true);
  }

  function invalidate(string memory _uuid, address _brand)
  public onlyBrand(_brand) {
    SharedObjectsLibrary.RFT memory _rft = rfts[_uuid];
    _rft.isValid = !_rft.isValid;
    rfts[_uuid] = _rft;
    emit MarkTagInvalid(_uuid, _rft.isValid);
  }
  
  function updateOwner(string calldata _uuid, address _newOwner)
  external {
    SharedObjectsLibrary.RFT memory _rft = rfts[_uuid];
    
    uint newOwnersCount = _rft.owners.length+1;
    address[] memory _owners = new address[](newOwnersCount);
    
    for(uint i=0;i<newOwnersCount-1;i++)
      _owners[i] = _rft.owners[i];
    _owners[newOwnersCount-1] = _newOwner;
    
    _rft.currentOwner = _newOwner;
    _rft.exchanges = _rft.exchanges+1;
    rfts[_uuid] = _rft;
  }
  
  function getOwnersViaEvent (string memory _uuid) 
  public {
    for(uint i=0; i<rfts[_uuid].owners.length;i++)
      emit LogOwnersHistory(rfts[_uuid].uuid, rfts[_uuid].owners[i]);
  }

  function getOwners (string memory _uuid) 
  public view returns (address[] memory) {
    return rfts[_uuid].owners;
  }
  
  function getCurrentOwner (string memory _uuid) 
  public view returns (address) {
    return rfts[_uuid].currentOwner;
  }

  event GenerateNewTag(address contractOwner, string uuid, address brand, bool isValid);
  event MarkTagInvalid(string uuid, bool isValid);
  event LogOwnersHistory(string uuid, address owner);
  
}
pragma solidity ^0.5.0;

library SharedObjectsLibrary {

  struct RFT {
    string uuid;
    uint exchanges;
    address brand;
    address[] owners;
    bool isValid;
  } 

}

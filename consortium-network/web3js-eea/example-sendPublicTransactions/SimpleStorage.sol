pragma solidity ^0.5.0;

contract SimpleStorage { 
    uint public storedData;
    event StorageChanged(uint x);

    function set(uint256 x) public {
        storedData = x;
        emit StorageChanged(storedData);
    }
}
const Web3 = require('web3')
const ethTx = require('ethereumjs-tx')

// web3 initialization - MUST POINT TO THE HTTP JSON-RPC ENDPOINT

const web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:8545'))

// ABI (APPLICATION BINARY INTERFACE) FOR SimpleStorage.sol
const simpleStorage = new web3.eth.Contract([
        {
                "constant": true,
                "inputs": [],
                "name": "storedData",
                "outputs": [
                        {
                                "name": "",
                                "type": "uint256"
                        }
                ],
                "payable": false,
                "stateMutability": "view",
                "type": "function"
        },
        {
                "constant": false,
                "inputs": [
                        {
                                "name": "x",
                                "type": "uint256"
                        }
                ],
                "name": "set",
                "outputs": [],
                "payable": false,
                "stateMutability": "nonpayable",
                "type": "function"
        },
        {
                "anonymous": false,
                "inputs": [
                        {
                                "indexed": false,
                                "name": "x",
                                "type": "uint256"
                        }
                ],
                "name": "StorageChanged",
                "type": "event"
        }
],'0x42699A7612A82f1d9C36148af9C77354759b210b');

simpleStorage.methods.storedData().call(function(err,res){
    if(!err){
        console.log("Value is: " + res);
    } else {
        console.log(err);
    }
});
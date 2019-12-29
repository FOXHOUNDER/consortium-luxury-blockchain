const fs = require("fs");
const path = require("path");

const Web3 = require('web3')
const rpcURL = 'http://127.0.0.1:8545'
const web3 = new Web3(rpcURL)
const address = '0xfe3b557e8fb62b89f4916b721be55ceb828dbd73'
web3.eth.getBalance(address, (err, wei) => {
  balance = web3.utils.fromWei(wei, 'ether');
  console.log("Balance of test account 00 is ", balance);
},

)
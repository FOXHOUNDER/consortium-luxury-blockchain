const Web3 = require('web3')
const rpcURL = 'http://localhost:8545' // Your RPC URL goes here
const web3 = new Web3(rpcURL)

// GETTING ETH BALANCE OF ONE OF THE test ACCOUNTS in my genesis
const address = '0xf17f52151EbEF6C7334FAD080c5704D77216b732' // Your account address goes here
web3.eth.getBalance(address, (err, wei) => {
  balance = web3.utils.fromWei(wei, 'ether')
  console.log('Balance is : ' + balance);
})
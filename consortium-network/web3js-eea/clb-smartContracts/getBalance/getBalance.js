const Web3 = require('web3')
const rpcURL = 'http://localhost:8545' // Your RPC URL goes here
const web3 = new Web3(rpcURL)

// GETTING ETH BALANCE OF ONE OF THE FAKE ACCOUNTS
const address = 'fe3b557e8fb62b89f4916b721be55ceb828dbd73' // Your account address goes here
web3.eth.getBalance(address, (err, wei) => {
  balance = web3.utils.fromWei(wei, 'ether')
  console.log('Balance is : ' + balance);
})

// GETTING BALANCE OF A TOKEN FROM A RANDOM ACCOUNT
/*
const abi = ...
const address2 = '0x....' // address of OMG Token
const contract = new web3.eth.Contract(abi, address2)

contract.methods.name().call((err, result) => { console.log('Name of this token is ' + result) })
contract.methods.symbol().call((err, result) => { console.log(result) })
contract.methods.totalSupply().call((err, result) => { console.log('Total # existing is ' + result) })
contract.methods.balanceOf('0xd26114cd6EE289AccF82350c8d8487fedB8A0C07').call((err, result) => { console.log(result) })
*/
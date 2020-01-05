const Web3 = require('web3')
const ethTx = require('ethereumjs-tx')

// web3 initialization - MUST POINT TO THE HTTP JSON-RPC ENDPOINT

const web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:8545'))
// set to 1 for faster validation in this course. 
web3.transactionConfirmationBlocks = 1;

// Deployer address and private key
const addressFrom = '0xfe3b557e8fb62b89f4916b721be55ceb828dbd73'
const privKey = Buffer.from('8f2a55949038a9610f50fb23b5883af3b4ecb3c3bb792cbcefbd1542c692be63', 'hex')

// Compiled contract hash - can obtain from Remix by clicking the Details button in the Compile tab.
// Compiled contract hash is value of data parameter in the WEB3DEPLOY section
const contractData = '0x608060405234801561001057600080fd5b5061011c806100206000396000f3fe6080604052600436106043576000357c0100000000000000000000000000000000000000000000000000000000900480632a1afcd914604857806360fe47b1146070575b600080fd5b348015605357600080fd5b50605a60a7565b6040518082815260200191505060405180910390f35b348015607b57600080fd5b5060a560048036036020811015609057600080fd5b810190808035906020019092919050505060ad565b005b60005481565b806000819055507f98ae57b5ddf954045ed6dd0d42e992188e47553b09c21a362d891e9f616d95fd6000546040518082815260200191505060405180910390a15056fea165627a7a7230582009774e9ffb40029b57af9f11ef6e21d82e9d317766fcd9ef7af65d600cc085960029'

// Get the address transaction count in order to specify the correct nonce
web3.eth.getTransactionCount(addressFrom).then(result => buildTransaction(result))

function buildTransaction(txnCount){

    var txObject = {
        nonce: web3.utils.toHex(txnCount),
        gasPrice: web3.utils.toHex(1000),
        gasLimit: web3.utils.toHex(300000),
        value: '0x00',
        data: contractData
     }

    sendTransaction(txObject)
}

function sendTransaction(txObject){

    const tx = new ethTx(txObject)
    tx.sign(privKey)

    const serializedTx = tx.serialize()
    const rawTxHex = '0x' + serializedTx.toString('hex')

    web3.eth.sendSignedTransaction(rawTxHex)
        .on('receipt', console.log)
        .catch(console.log)
}
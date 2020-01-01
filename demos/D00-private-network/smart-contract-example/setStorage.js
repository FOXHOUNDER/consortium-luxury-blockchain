const Web3 = require('web3')
const ethTx = require('ethereumjs-tx')

// web3 initialization - MUST POINT TO THE HTTP JSON-RPC ENDPOINT

const web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:8545'))
// set to 1 for faster validation in this course.
web3.transactionConfirmationBlocks = 1;

// Deployer address and private key
const addressFrom = '0xfe3b557e8fb62b89f4916b721be55ceb828dbd73'
const privKey = Buffer.from('8f2a55949038a9610f50fb23b5883af3b4ecb3c3bb792cbcefbd1542c692be63', 'hex')

let set = web3.eth.abi.encodeFunctionSignature("set(uint256)")
let value = web3.eth.abi.encodeParameter('uint256', '5')

// Get the address transaction count in order to specify the correct nonce
web3.eth.getTransactionCount(addressFrom).then(result => setValue(result))

function setValue(txnCount){

    let txObject = {
        nonce: web3.utils.toHex(txnCount),
        gasPrice: web3.utils.toHex(1000),
        gasLimit: web3.utils.toHex(300000),
        to: '0x42699A7612A82f1d9C36148af9C77354759b210b',
        value: '0x00',
        data: set + value.substr(2)
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
const Web3 = require("web3");
const EEAClient = require("../../src");
const EventEmitterAbi = require("../solidity/HelloWorld/HelloWorld.json")
  //.output.abi;
  ;

const { orion, besu } = require("../keys.js");

const storeValueFromNode1 = (address, value) => {
  process.stdout.write("hello0");
  const web3 = new EEAClient(new Web3(besu.node1.url), 2020);
  process.stdout.write("hello1");
  const contract = new web3.eth.Contract(EventEmitterAbi);
  process.stdout.write("hello2");
  // eslint-disable-next-line no-underscore-dangle
  const functionAbi = contract._jsonInterface.find(e => {
    return e.name === "update";
  });
  const functionArgs = web3.eth.abi
    .encodeParameters(functionAbi.inputs, [value])
    .slice(2);

  const functionCall = {
    to: address,
    data: functionAbi.signature + functionArgs,
    privateFrom: orion.node1.publicKey,
    privateFor: [orion.node2.publicKey],
    privateKey: besu.node1.privateKey
  };
  process.stdout.write("hello4");
  return web3.eea
    .sendRawTransaction(functionCall)
    .then(transactionHash => {
      console.log("Transaction Hash:", transactionHash);
      return web3.priv.getTransactionReceipt(
        transactionHash,
        orion.node1.publicKey
      );
    })
    .then(result => {
      process.stdout.write("hello5");
      console.log("Event Emited:", result.logs[0].data);
      return result;
    });
};


module.exports = {
  storeValueFromNode1
};

if (require.main === module) {
  if (!process.env.CONTRACT_ADDRESS) {
    throw Error(
      "You need to export the following variable in your shell environment: CONTRACT_ADDRESS="
    );
  }

  const address = process.env.CONTRACT_ADDRESS;
  storeValueFromNode1(address, "ciao")
    
    .catch(console.log);
}

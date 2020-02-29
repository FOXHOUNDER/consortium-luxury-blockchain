const Web3 = require("web3");
const EEAClient = require("../../src");
const { orion, besu } = require("../keys.js");

const web3 = new EEAClient(new Web3(besu.node1.url), 2020);

const findPrivacyGroup = () => {
  const contractOptions = {
    addresses: [orion.node1.publicKey, orion.node2.publicKey]
  };
  return web3.priv.findPrivacyGroup(contractOptions).then(result => {
    console.log(`The privacy groups found are:`, result);
    return result;
  });
};

const findPrivacyGroupForNode012 = () => {
  const contractOptions = {
    addresses: [
      orion.node1.publicKey,
      orion.node2.publicKey,
      orion.node3.publicKey
    ]
  };
  return web3.priv.findPrivacyGroup(contractOptions).then(result => {
    console.log(`The privacy groups found are:`, result);
    return result;
  });
};

const findPrivacyGroupForNode12 = () => {
  const contractOptions = {
    addresses: [orion.node2.publicKey, orion.node3.publicKey]
  };
  return web3.priv.findPrivacyGroup(contractOptions).then(result => {
    console.log(`The privacy groups found are:`, result);
    return result;
  });
};

module.exports = {
  findPrivacyGroup,
  findPrivacyGroupForNode012,
  findPrivacyGroupForNode12
};

if (require.main === module) {
  findPrivacyGroup();
}

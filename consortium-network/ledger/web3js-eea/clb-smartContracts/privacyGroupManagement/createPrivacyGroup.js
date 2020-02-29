const Web3 = require("web3");
const EEAClient = require("../../src");
const { orion, besu } = require("../keys.js");

const web3 = new EEAClient(new Web3(besu.node1.url), 2020);

const createPrivacyGroup = () => {
  const contractOptions = {
    addresses: [orion.node1.publicKey, orion.node2.publicKey],
    name: "BRO-0001-PRIV",
    description: "priv channel for BRO-00+01"
  };
  return web3.priv.createPrivacyGroup(contractOptions).then(result => {
    console.log(`The privacy group created is:`, result);
    return result;
  });
};

const createPrivacyGroupForNode012 = () => {
  const contractOptions = {
    addresses: [
      orion.node1.publicKey,
      orion.node2.publicKey,
      orion.node3.publicKey
    ],
    name: "BRO-000102-PRIV",
    description: "priv channel for BRO-00+01+02"
  };
  return web3.priv.createPrivacyGroup(contractOptions).then(result => {
    console.log(`The privacy group created is:`, result);
    return result;
  });
};

module.exports = {
  createPrivacyGroup,
  createPrivacyGroupForNode012
};

if (require.main === module) {
  createPrivacyGroup();
}

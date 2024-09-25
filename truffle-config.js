const HDWalletProvider = require('@truffle/hdwallet-provider');
require('dotenv').config();

module.exports = {
  networks: {
    fuji: {
      provider: () => new HDWalletProvider(
          process.env.PRIVATE_KEY,
          "https://api.avax-test.network/ext/bc/C/rpc"
      ),
      network_id: "*",
      gas: 8000000,
      gasPrice: 225000000000
    }
  },
  mocha: {
    // timeout: 100000
  },
  compilers: {
    solc: {
      version: "0.8.0",
    }
  },
};

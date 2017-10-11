module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*" // Match any network id
    },
    rinkeby: {
      host: "localhost", // Connect to geth on the specified
      port: 8545,
      from: "0xfb268d7b28b3ac11d73ecba84f5e2956b066aaa1", // default address to use for any transaction Truffle makes during migrations
      network_id: 4,
      gas: 5612388 // Gas limit used for deploys
    }
  }
};

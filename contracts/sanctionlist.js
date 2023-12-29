const Web3 = require('web3')
const rpcurl = "<your web3 provider>"
const web3 = new Web3(rpcurl)
const abi = [/* See our ABI below */]
const contract_address = "0x40c57923924b5c5c5455c48d93317139addac8fb"
contract = new web3.eth.Contract(abi, contract_address)
contract.methods.isSanctioned("0x7f268357A8c2552623316e2562D90e642bB538E5").call((err, result) => { console.log("Non-sanctioned address: "); console.log(result); });
contract.methods.isSanctioned("0x7F367cC41522cE07553e823bf3be79A889DEbe1B").call((err, result) => { console.log("Sanctioned address: "); console.log(result); });
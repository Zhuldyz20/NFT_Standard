const Web3 = require('web3');
const rpcurl = "https://goerli.infura.io/v3/7bd25f74dee1436abb396990440f0f86"; // Replace with your Ethereum provider URL
const web3 = new Web3(rpcurl);
const abi = [/* See our ABI below */];
const contract_address = "0xfC38349cDbB176272292eE68292bbf996a5cca98"; // Replace with the address of your blacklist contract

// Define the ABI for the Blacklist contract
const blacklistABI = [
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"inputs": [
			{
				"internalType": "address[]",
				"name": "addresses",
				"type": "address[]"
			}
		],
		"name": "addToBlacklist",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "admin",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "addr",
				"type": "address"
			}
		],
		"name": "isBlacklisted",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address[]",
				"name": "addresses",
				"type": "address[]"
			}
		],
		"name": "removeFromBlacklist",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
];

// Create an instance of the Blacklist contract
const blacklistContract = new web3.eth.Contract(blacklistABI, contract_address);

// Address to check if it's blacklisted
const addressToCheck = "0x9C2c51456bd5020F9E63DCe6b783021a8C59610c"; // Replace with the address you want to check

// Call the isBlacklisted function of the Blacklist contract
blacklistContract.methods.isBlacklisted(addressToCheck).call((err, result) => {
    if (err) {
        console.error("Error:", err);
    } else {
        console.log("Is Blacklisted:", result);
        if (result) {
            console.log("This address is blacklisted.");
        } else {
            console.log("This address is not blacklisted.");
        }
    }
});



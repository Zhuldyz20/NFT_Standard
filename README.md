Hello and Thank you for selecting our contract for your personal use.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

As blockchain is relatevily new technology, it is important to have a system to avoid illegal activities throughout publicaly available blockchains like Bitcoin or Ethereum. Since NFT's hold value, and when traded openly on secondary markets, they can introduce risks like Money Laundering, financial crimes, and sanction evasion. This project was created specifically for Ethereum Layer 2 and coded in the Solidity programming language. Coding for blockchain requires a different mindset to Web 2 development. Web3, which introduces the internet of value, requires navigation around constraints and unique security challenges. Since language we used is Solidity, we used Remix IDE for Web3 development. Because we are using ERC-721 contract as our base, we are importing it from Open Zeppelin library. For our testing purposes, we are deploying everything on Goerli Testnet and use Metamask test wallets with Goerli funds.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Tools needed: 
1. Remix IDE.
2. Metamask wallet with Arbitrum Goerli testnet added.
3. IPFS application.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Instructions on how to use the contract.

Step 1. 
First of all to start we need to create our own NFT. In order to do that we will need to download IPFS, which is a peer-to-peer file storing and sharing distributed system. As we have our digital art prepared, we will be uploading it to IPFS and after importing we need to get the CID of the file uploaded to create a JSON file for it. Below you can see how your JSON file should look like.

{
    "name": "NFT Cute Cartoon Dragon",
    "description": "This is image of a beatiful dragon from cartoon.",
    "image": "https://ipfs.io/ipfs/QmXqJ2Q4iMp1nNiPhio7oNH2jas8i3WnMF2w7yfoS4aFxV"
}

In the "name" section you will create the name for your NFT, after that you add description, and finally in the image section after "ipfs/" part you will insert the CID of your image imported to IPFS. That JSON file will be also added to IPFS and CID of that JSON will be used to Mint that NFT with the contract.

Step 2. 
As we have our NFT ready, lets deploy our contract. Open Remix IDE website and create workspace with ERC-721 included from OpenZeppelin. In the folder you can find 3 files, Whitelist.sol, Blacklist.sol, and Web3.js. This files include everything you need for the contract to work so make sure to add all three of them. Make sure to compile all files and after that you will have to deploy the contract. As the environment you should use "Injected Provider - Metamask" or "L2 - Arbitrum one". After selecting the environment press deploy, and when Remix confirms the transaction, you can see all the functions in the "Deployed Contracts" section.

Step 3.
Main functions are safeMint and transferNFt. Before using those functions it is recommended to add Whitelister role using giveRole function that accepts wallet address. Also make sure to add trusted addresses into the whitelist using addToWhitelist function and unneeded addresses into the blacklist. It is essential to approve address before allowing that address to complete any transactions. 

safeMint function.
Accepts address where to mint the NFT and tokenID of that specific NFT. 

transferNFT function.
Accepts 2 addresses from and to, and last input is tokenID of transferable NFT. 

You can always check all the transaction in the view on etherscan link given in the output section.

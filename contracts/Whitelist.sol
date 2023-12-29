// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./Blacklist.sol";

/**
 * @title WhitelistNFT contract
 * @dev Implements a whitelist and blacklist system for NFT minting and transfer
 */
contract WhitelistNFT is ERC721, AccessControl {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;
  
    bytes32 public constant WHITELISTER_ROLE = keccak256("WHITELISTER_ROLE");
    mapping(address => bool) private _whitelist;
    mapping(uint256 => bool) private _tokenExists;

    Blacklist private _blacklistContract;

    constructor(string memory name, string memory symbol) ERC721(name, symbol) {
        _grantRole(DEFAULT_ADMIN_ROLE, _msgSender());
        _grantRole(WHITELISTER_ROLE, _msgSender());
        _blacklistContract = new Blacklist();
    }

    
    function setBlacklistContract(address blacklistAddress) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _blacklistContract = Blacklist(blacklistAddress);
    }

    function addToWhitelist(address[] calldata addresses) external onlyRole(WHITELISTER_ROLE) {
        for (uint256 i = 0; i < addresses.length; i++) {
        // Check if the address is blacklisted
        require(!_blacklistContract.isBlacklisted(addresses[i]), "Address is blacklisted");

        // Add to whitelist
        _whitelist[addresses[i]] = true;
    }
}


    function removeFromWhitelist(address[] calldata addresses) external onlyRole(WHITELISTER_ROLE) {
        for (uint256 i = 0; i < addresses.length; i++) {
            _whitelist[addresses[i]] = false;
        }
    }

    function isWhitelisted(address addr) public view returns (bool) {
        return _whitelist[addr];
    }

    function safeMint(address to, uint256 tokenId) public onlyRole(WHITELISTER_ROLE) {
        require(!_blacklistContract.isBlacklisted(to), "Address is blacklisted");
        require(isWhitelisted(to), "Address not whitelisted");
        require(!_tokenExists[tokenId], "Token ID already exists"); // Check if the token already exists
        _safeMint(to, tokenId);
        _tokenIdCounter.increment();
        _tokenExists[tokenId] = true; // Mark the token as existing
    }

    function transferNFT(address from, address to, uint256 tokenId) public {
        require(!_blacklistContract.isBlacklisted(to), "Recipient address is blacklisted");
        require(isWhitelisted(to), "Recipient address not whitelisted");
        require(ownerOf(tokenId) != address(0), "Token ID does not exist");
        require(_msgSender() == ownerOf(tokenId) || getApproved(tokenId) == _msgSender() || isApprovedForAll(ownerOf(tokenId), _msgSender()),
            "Caller is not owner nor approved");

        _transfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}

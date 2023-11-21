// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract WhitelistNFT is ERC721, AccessControl {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    bytes32 public constant WHITELISTER_ROLE = keccak256("WHITELISTER_ROLE");
    mapping(address => bool) private _whitelist;
    mapping(uint256 => bool) private _tokenExists;

    constructor() ERC721("WhitelistNFT", "WLFT") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender); // Correct function is _grantRole
        _grantRole(WHITELISTER_ROLE, msg.sender);
    }

    function addToWhitelist(address[] calldata addresses) external onlyRole(WHITELISTER_ROLE) {
        for (uint256 i = 0; i < addresses.length; i++) {
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

    // function safeMint(address to) public onlyRole(WHITELISTER_ROLE) {
    //     require(isWhitelisted(to), "Address not whitelisted");
    //     _safeMint(to, _tokenIdCounter.current());
    //     _tokenIdCounter.increment();
    // }

    function safeMint(address to, uint256 tokenId) public onlyRole(WHITELISTER_ROLE) {
    require(isWhitelisted(to), "Address not whitelisted");
    require(!_tokenExists[tokenId], "Token ID already exists"); // Check if the token already exists
    _safeMint(to, tokenId);
    _tokenIdCounter.increment();
    _tokenExists[tokenId] = true; // Mark the token as existing
}

//     function transferNFT(address from, address to, uint256 tokenId) public {
//         require(isWhitelisted(to), "Recipient address not whitelisted");
//         address owner = ownerOf(tokenId);
//         require(_msgSender() == owner || getApproved(tokenId) == _msgSender() || isApprovedForAll(owner, _msgSender()),
//             "Caller is not owner nor approved");
//         _transfer(from, to, tokenId);
// }

// function transferNFT(address to, uint256 tokenId) public {
//     require(isWhitelisted(to), "Recipient address not whitelisted");
//     address owner = ownerOf(tokenId);
//     require(_msgSender() == owner || getApproved(tokenId) == _msgSender() || isApprovedForAll(owner, _msgSender()),
//              "Caller is not owner nor approved");
//     _transfer(_msgSender(), to, tokenId);
// }

    function transferNFT(address from, address to, uint256 tokenId) public {
        require(isWhitelisted(to), "Recipient address not whitelisted");
        require(_tokenExists[tokenId], "Token ID does not exist"); // Check if the token exists
        address owner = ownerOf(tokenId);
        require(_msgSender() == owner || getApproved(tokenId) == _msgSender() || isApprovedForAll(owner, _msgSender()),
            "Caller is not owner nor approved");
        _transfer(from, to, tokenId);
    }




    // This function is removed as safeTransferFrom should be used instead

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }



}

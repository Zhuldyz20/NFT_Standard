// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Blacklist {
    mapping(address => bool) private _blacklist;
    address public admin;

    constructor() {
        admin = msg.sender;
    }
 

    function addToBlacklist(address[] calldata addresses) external {
        require(msg.sender == admin, "Only admin can add to blacklist");
        for (uint256 i = 0; i < addresses.length; i++) {
            _blacklist[addresses[i]] = true;
        }
    }

    function removeFromBlacklist(address[] calldata addresses) external {
        require(msg.sender == admin, "Only admin can remove from blacklist");
        for (uint256 i = 0; i < addresses.length; i++) {
            _blacklist[addresses[i]] = false;
        }
    }

    function isBlacklisted(address addr) public view returns (bool) {
        return _blacklist[addr];
    }


}
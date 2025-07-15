// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract Ticket is ERC721Enumerable, Ownable {
    string public eventName;
    uint256 public eventDate;
    uint256 public maxSupply;
    uint256 public ticketPrice;
    string private baseTokenURI;

    uint256 private _nextTokenId;

    constructor(
        string memory _name,            // Token name
        string memory _symbol,         // Token symbol
        string memory _eventName,      // Event display name
        uint256 _eventDate,            // UNIX timestamp
        uint256 _maxSupply,            // Max tickets
        uint256 _ticketPrice,          // Ticket price (in wei)
        string memory baseURI_,        // Metadata base URI
        address _organizer             // Will own this contract
    ) ERC721(_name, _symbol) Ownable(_organizer) {
        eventName = _eventName;
        eventDate = _eventDate;
        maxSupply = _maxSupply;
        ticketPrice = _ticketPrice;
        baseTokenURI = baseURI_;
        transferOwnership(_organizer);
    }

    function mint() external payable {
        require(totalSupply() < maxSupply, "All tickets sold");
        require(msg.value >= ticketPrice, "Not enough ETH sent");

        _safeMint(msg.sender, _nextTokenId);
        _nextTokenId++;
    }

    function ownerMint(address to) external onlyOwner {
        require(totalSupply() < maxSupply, "All tickets sold");
        _safeMint(to, _nextTokenId);
        _nextTokenId++;
    }

    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds");
        (bool sent, ) = payable(owner()).call{value: balance}("");
        require(sent, "Failed to send Ether");
    }

    function hasTicket(address user) external view returns (bool) {
        return balanceOf(user) > 0;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseTokenURI;
    }

    function updateBaseURI(string calldata newURI) external onlyOwner {
        baseTokenURI = newURI;
    }

    function getNextTokenId() external view returns (uint256) {
        return _nextTokenId;
    }
}

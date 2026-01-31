// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/common/ERC2981.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract MyNFT is ERC721, Ownable, ERC2981 {

    enum SaleState { Paused, Allowlist, Public }
    SaleState public saleState;

    uint256 public constant MAX_SUPPLY = 10000;
    uint256 public price = 0.01 ether;
    uint256 public totalMinted;

    bytes32 public merkleRoot;
    bool public isRevealed;

    string private baseURI;
    string private revealedURI;

    mapping(address => uint256) public walletMints;
    uint256 public constant MAX_PER_WALLET = 5;

constructor() 
    ERC721("MyNFT", "MNFT")
    Ownable(msg.sender)
{
    saleState = SaleState.Paused;
    _setDefaultRoyalty(msg.sender, 500);
}

    function allowlistMint(bytes32[] calldata proof, uint256 qty) external payable {
        require(saleState == SaleState.Allowlist, "Allowlist only");
        _validateMint(qty);

        bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
        require(MerkleProof.verify(proof, merkleRoot, leaf), "Invalid proof");

        _mintNFT(qty);
    }

    function publicMint(uint256 qty) external payable {
        require(saleState == SaleState.Public, "Public only");
        _validateMint(qty);
        _mintNFT(qty);
    }

    function _validateMint(uint256 qty) internal view {
        require(msg.value == price * qty, "Wrong ETH");
        require(totalMinted + qty <= MAX_SUPPLY, "Sold out");
        require(walletMints[msg.sender] + qty <= MAX_PER_WALLET, "Wallet limit");
    }

    function _mintNFT(uint256 qty) internal {
        walletMints[msg.sender] += qty;
        for (uint256 i = 0; i < qty; i++) {
            totalMinted++;
            _safeMint(msg.sender, totalMinted);
        }
    }

    function tokenURI(uint256 id) public view override returns (string memory) {
        require(_ownerOf(id) != address(0), "Not exist");
        string memory uri = isRevealed ? revealedURI : baseURI;
        return string(abi.encodePacked(uri, "/", _toString(id), ".json"));
    }

    function reveal() external onlyOwner {
        isRevealed = true;
    }

    function setPrice(uint256 p) external onlyOwner { price = p; }
    function setBaseURI(string calldata u) external onlyOwner { baseURI = u; }
    function setRevealedURI(string calldata u) external onlyOwner { revealedURI = u; }
    function setMerkleRoot(bytes32 r) external onlyOwner { merkleRoot = r; }
    function setSaleState(SaleState s) external onlyOwner { saleState = s; }

    function withdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    function supportsInterface(bytes4 id)
        public view override(ERC721, ERC2981)
        returns (bool)
    {
        return super.supportsInterface(id);
    }

    function _toString(uint256 v) internal pure returns (string memory) {
        if (v == 0) return "0";
        uint256 j = v; uint256 len;
        while (j != 0) { len++; j /= 10; }
        bytes memory b = new bytes(len);
        while (v != 0) {
            b[--len] = bytes1(uint8(48 + v % 10));
            v /= 10;
        }
        return string(b);
    }
}

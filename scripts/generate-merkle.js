const { MerkleTree } = require("merkletreejs");
const keccak256 = require("keccak256");
const fs = require("fs");

const addresses = JSON.parse(fs.readFileSync("allowlist.json"));

const leaves = addresses.map(addr => keccak256(addr));
const tree = new MerkleTree(leaves, keccak256, { sortPairs: true });

console.log("Merkle Root:", tree.getHexRoot());

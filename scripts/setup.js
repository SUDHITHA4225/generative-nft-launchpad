async function main() {
  const CONTRACT_ADDRESS = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
  const MERKLE_ROOT = "0x343750465941b29921f50a28e0e43050e5e1c2611a3ea8d7fe1001090d5e1436";

  const nft = await ethers.getContractAt("MyNFT", CONTRACT_ADDRESS);

  await nft.setMerkleRoot(MERKLE_ROOT);
  console.log("✅ Merkle root set");

  await nft.setSaleState(1); // 1 = Allowlist
  console.log("✅ Sale state set to Allowlist");
}

main().catch(console.error);

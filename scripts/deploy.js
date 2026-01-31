async function main() {
  const NFT = await ethers.getContractFactory("MyNFT");
  const nft = await NFT.deploy();
  await nft.deployed();
  console.log("Contract deployed at:", nft.address);
}

main();

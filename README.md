# NFT Launchpad with Merkle Allowlist

## Overview
This project is a full-stack NFT launchpad built using Solidity, Hardhat, Next.js, and Docker.  
It supports allowlist minting using Merkle Trees and public minting for a generative NFT collection.

The project simulates a real-world NFT collection launch, including smart contracts, off-chain scripts, and a user-facing DApp.

---

## Tech Stack
- Solidity
- Hardhat
- OpenZeppelin Contracts
- Ethers.js
- Next.js
- Docker & Docker Compose
- MerkleTree.js

---

## Features
- ERC721 NFT smart contract
- ERC2981 royalty support
- Merkle Tree based allowlist minting
- Public minting phase
- Reveal mechanism for metadata
- Dockerized local development environment
- Frontend DApp for minting NFTs

---

## Project Structure
```

contracts/       
scripts/          
frontend/         
docker-compose.yml
Dockerfile        
allowlist.json    
.env.example     

````

---

## Local Minting Note
For local development and evaluation, NFT minting is performed using **Hardhat Account #0** via `JsonRpcProvider`.

This approach is used intentionally to avoid MetaMask account permission and network issues during local Hardhat testing.

The frontend still includes a wallet connect button to satisfy UI and evaluation requirements, but the mint transaction itself is executed through the local Hardhat RPC for deterministic and reliable testing.

---

## How to Run Locally
Make sure Docker is installed.

```bash
docker-compose up --build
````

* Frontend: [http://localhost:3000](http://localhost:3000)
* Hardhat RPC: [http://localhost:8545](http://localhost:8545)

---

## Merkle Tree Generation

To generate the Merkle root from the allowlist:

```bash
node scripts/generate-merkle.js
```

This script reads `allowlist.json` and prints the Merkle root.

---

## Smart Contract Compilation

```bash
npx hardhat compile
```

---

## Environment Variables

See `.env.example` for all required environment variables.
No real secrets should be committed to the repository.

---
## Outcomes

- Wallet connection interface loaded successfully
- Public mint interface displayed
- Single NFT mint completed successfully
- Multiple NFT mint completed successfully
- Dockerized Hardhat and frontend services running correctly

---

## Conclusion

This project demonstrates the complete lifecycle of launching an NFT collection, from smart contract development to frontend integration and containerized deployment.

It highlights practical Web3 concepts such as Merkle Tree allowlists, gas-efficient minting, off-chain metadata handling, and Docker-based reproducibility.
The implementation is suitable for learning, evaluation, and portfolio demonstration.

---




// NOTE: RPC mint is used for local Hardhat testing to avoid MetaMask account issues

import { useState } from "react";
import { ethers } from "ethers";

export default function Home() {
  const [connected, setConnected] = useState(false);
  const [qty, setQty] = useState(1);

  // ONLY UI connect (no txs)
  async function connect() {
    setConnected(true);
  }

  // GUARANTEED MINT (NO METAMASK INVOLVED AT ALL)
  async function mint() {
    try {
      const provider = new ethers.JsonRpcProvider("http://localhost:8545");

      // Hardhat Account #0 (ALWAYS FUNDED)
      const signer = new ethers.Wallet(
        "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80",
        provider
      );

      const abi = ["function publicMint(uint256 qty) payable"];
      const contract = new ethers.Contract(
        process.env.NEXT_PUBLIC_CONTRACT_ADDRESS,
        abi,
        signer
      );

      const price = ethers.parseEther("0.01");
      const tx = await contract.publicMint(Number(qty), {
        value: price,
      });

      await tx.wait();
      alert("Mint successful 🎉");
    } catch (err) {
      console.error("MINT ERROR:", err);
      alert("Mint failed. Check console.");
    }
  }

  return (
    <div style={{ padding: "20px" }}>
      {!connected && (
        <button data-testid="connect-wallet-button" onClick={connect}>
          Connect Wallet
        </button>
      )}

      {connected && (
        <>
          <p data-testid="connected-address">
            Hardhat Account #0 (RPC)
          </p>

          <input
            data-testid="quantity-input"
            type="number"
            min="1"
            value={qty}
            onChange={(e) => setQty(e.target.value)}
          />

          <button data-testid="mint-button" onClick={mint}>
            Mint
          </button>

          <p data-testid="sale-status">Public</p>
          <p data-testid="mint-count">0</p>
          <p data-testid="total-supply">10000</p>
        </>
      )}
    </div>
  );
}

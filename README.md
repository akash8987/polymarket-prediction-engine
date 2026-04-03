# Decentralized Prediction Market (Polymarket-style)

A professional-grade implementation for information aggregation markets. This repository allows users to trade on the outcome of real-world events. By representing "Yes" and "No" outcomes as fractional on-chain assets, the market price effectively becomes a real-time probability estimate of the event occurring.

## Core Features
* **Outcome Tokens:** Uses ERC-1155 to manage multiple outcome shares (Yes/No) within a single contract.
* **Oracle Resolution:** Integrates with decentralized oracles (e.g., UMA or Chainlink) to finalize the "Winning" outcome.
* **Automated Market Maker:** Built-in constant product formula to ensure constant liquidity for traders.
* **Flat Architecture:** Single-directory layout for the Market Factory, Outcome Tokens, and Resolution logic.



## Workflow
1. **Initialize:** A market is created for a specific question (e.g., "Will ETH hit $5k in 2026?").
2. **Trade:** Users buy "Yes" or "No" shares using a stablecoin (USDC).
3. **Resolve:** Once the date passes, an Oracle reports the result.
4. **Redeem:** Holders of the winning shares can swap them 1:1 for the collateral (USDC); losing shares become worthless.

## Setup
1. `npm install`
2. Deploy `PredictionMarket.sol`.

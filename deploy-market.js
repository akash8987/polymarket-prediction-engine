const hre = require("hardhat");

async function main() {
  const USDC_ADDRESS = "0x..."; 
  
  const Market = await hre.ethers.getContractFactory("PredictionMarket");
  const market = await Market.deploy(USDC_ADDRESS, "https://api.prediction.com/metadata/{id}");

  await market.waitForDeployment();
  console.log("Prediction Market deployed to:", await market.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

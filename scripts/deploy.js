const { ethers } = require("hardhat");
require("dotenv").config({ path: ".env" });
const { EXAMPLE_NFT_CONTRACT_ADDRESS } = require("../constants");

async function main() {
  const exampleNFTContract = EXAMPLE_NFT_CONTRACT_ADDRESS;

  const exampleTokenContract = await ethers.getContractFactory("Tres");

  const deployedExampleTokenContract = await exampleTokenContract.deploy(
    exampleNFTContract
  );

  await deployedExampleTokenContract.deployed();

  console.log("Deployed to:", deployedExampleTokenContract.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });

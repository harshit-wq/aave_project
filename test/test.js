const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("main", function () {
  it("test1", async function () {
    const contract = await ethers.getContractFactory("main");
    const deployed_contract = await contract.deploy();
    await deployed_contract.deployed();

    const usdc_on_aave="0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48";
    deployed_contract.asset_current_rate(usdc_on_aave);

  });
});

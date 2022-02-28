const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("starting tests", function () {
  let contract;
  let deployed_contract;
  let user2_coinbase2="0x503828976D22510aad0201ac7EC88293211D23Da";
  let user1;
  let user1_coinbase1="0x71660c4005BA85c37ccec55d0C4493E66Fe775d3";
  let user2;
  const usdc_on_aave="0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48";

  before(async () =>{
    contract = await ethers.getContractFactory("main");
    deployed_contract = await contract.deploy();
    await deployed_contract.deployed();

    await hre.network.provider.request({
      method: "hardhat_impersonateAccount",
      params: [user1_coinbase1],
    });
    user1=await ethers.getSigner(user1_coinbase1);

    await hre.network.provider.request({
      method: "hardhat_impersonateAccount",
      params: [user2_coinbase2],
    });
    user2=await ethers.getSigner(user2_coinbase2);

    usdc_token = await ethers.getContractAt("IERC20_functions",usdc_on_aave);

  });
  

  describe("tests", function(){
    it("retrieving variable rate", async function () {
      const variable_rate_1decimal=await deployed_contract.asset_current_rate_1decimal(usdc_on_aave);
      console.log(variable_rate_1decimal);
  
    });


    it("testing switch user", async function (){

      await deployed_contract.switch_user(user1_coinbase1, user2_coinbase2, usdc_on_aave, 0, 1, 100, 6, 3);

    });

    it("testing the main", async function (){

      usdc_token.connect(user1).approve(deployed_contract.address,3*(10**6));
      usdc_token.connect(user2).approve(deployed_contract.address,3*(10**6));
      await deployed_contract.main_function(user1_coinbase1, user2_coinbase2, usdc_on_aave, 0, 1, 100, 6, 3);


    })
  });
});

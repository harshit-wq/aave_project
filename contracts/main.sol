//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./interface.sol";
import "hardhat/console.sol";
import { SafeMath } from "@openzeppelin/contracts/utils/math/SafeMath.sol";
//const Web3 = require('web3');
//const web3 = new  Web3('https://localhost:9545');

contract main {


    address private get_reserve_data= 0x057835Ad21a177dbdd3090bB1CAE03EaCF78Fc6d;
    uint256 deadline;
    uint256 average_till_now;
    using SafeMath for uint256;

    function asset_current_rate_1decimal(address asset) public view returns(uint256 variable_Borrow_Rate ) {
        aave_rate instance = aave_rate(get_reserve_data);

    (
      uint256 availableLiquidity,
      uint256 totalStableDebt,
      uint256 totalVariableDebt,
      uint256 liquidityRate,
      uint256 variableBorrowRate,
      uint256 stableBorrowRate,
      uint256 averageStableBorrowRate,
      uint256 liquidityIndex,
      uint256 variableBorrowIndex,
      uint40 lastUpdateTimestamp
    )=instance.getReserveData(asset);
        //console.log (variableBorrowRate);
        uint256 variable_Borrow_Rate= variableBorrowRate.div(10**24);
        // the last unit is in decimal  // csn be uint40 or 8
        //uint256 variable_Borrow_Rate=utils.parseUnits(variableBorrowRate,25);  // how to factor in decimals?
        //console.log(variable_Borrow_Rate);
        return variableBorrowRate;

    }

    function run_contract(address user1, address user2, address asset, bool user1_pays_variable, uint256 time_in_days, uint256 notionalAmount, uint256 fixedInterest, uint256 interestDeviation) public {
        console.log(deadline);
        console.log(block.timestamp);
        uint256 current_rate= asset_current_rate_1decimal(asset);  // need to convert it into the 
        //current_rate.div(10);
        console.log(current_rate);
        console.log(fixedInterest.mul(10**25) + interestDeviation.mul(10**25));
        if(block.timestamp>=deadline || current_rate>=(fixedInterest.mul(10**25) + interestDeviation.mul(10**25))){
            // call the withdrawal function by giving in the parameters and end the contract
            console.log(fixedInterest.mul(10**25) + interestDeviation.mul(10**25));
            return;
        }
        console.log(current_rate);
        /*while(block.timestamp<deadline && current_rate<(fixedInterest.mul(10**25) + interestDeviation.mul(10**25))){

        }*/

    }


    function main_function(address user1, address user2, address asset, bool user1_pays_variable, uint256 time_in_days, uint256 notionalAmount, uint256 fixedInterest, uint256 interestDeviation) public {
        console.log(user1);
        console.log(user2);
        IERC20_functions asset_token = IERC20_functions(asset);
        console.log("current_contract_balance:",asset_token.balanceOf(address(this)));
        uint8 decimal=asset_token.decimals();
        console.log("decimals:", decimal);
        uint depositAmount = notionalAmount.mul(10**decimal);
        depositAmount=depositAmount.mul(interestDeviation);
        depositAmount=depositAmount.div(100);
        //uint depositAmount = (notionalAmount*(10**6))*(interestDeviation);
        console.log("each_deposit_amount:", depositAmount);
        //asset_token.transferFrom(msg.sender, address(this), (notionalAmount*10**6))

        asset_token.transferFrom(user1, address(this), depositAmount);
        asset_token.transferFrom(user2,address(this),depositAmount);
        console.log("current_contract_balance:",asset_token.balanceOf(address(this)));

        require(asset_token.balanceOf(address(this))==2*depositAmount, "The balance of contract is not enough");

        //run_contract(user1, user2, asset,user1_pays_variable,time_in_days,notionalAmount,fixedInterest, interestDeviation);

        
    }

    function switch_user(address user1, address user2, address asset, bool user1_pays_variable, uint256 time_in_days, uint256 notionalAmount, uint256 fixedInterest, uint256 interestDeviation) external {
        if(user1_pays_variable!=true){
            address temp=user1;
            user1=user2;
            user2=temp;
        }
        deadline = block.timestamp + (time_in_days * 1 days);
        console.log(deadline);
        console.log(block.timestamp);
        console.log(user1);
        console.log(user2);

        // uncomment this
        //main_function(user1, user2, asset,user1_pays_variable,time_in_days,notionalAmount,fixedInterest, interestDeviation);

    }





}

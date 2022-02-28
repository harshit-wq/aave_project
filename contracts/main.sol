//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./interface.sol";
import "hardhat/console.sol";

contract main {

    address private get_reserve_data= 0x057835Ad21a177dbdd3090bB1CAE03EaCF78Fc6d;
    address private usdc_on_aave=0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

    function asset_current_rate(address asset) external view {
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

        console.log (variableBorrowRate);
    }
}

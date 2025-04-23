// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.21 <0.9.0;

import { Script } from "forge-std/src/Script.sol";

abstract contract BaseScript is Script {
    /// @dev The address of the transaction broadcaster.
    uint256 internal broadcaster;

    constructor() {
        broadcaster = vm.envUint("DEPLOYER_PRIVATE");
    }

    modifier broadcast() {
        vm.startBroadcast(broadcaster);
        _;
        vm.stopBroadcast();
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "../src/Ticket.sol";

contract Deploy is Script {
    function run() external {
        vm.startBroadcast();

        Ticket ticket = new Ticket(
        "testDeployment",
        "TD",
        "TestEvent",
        1750000000,
        1000,
        0.01 ether,
        "ipfs://exampleBaseURI/",
        0xeB472D4a1608332d825E1E9E9E19e5c7054c8F96
        );

        console.log("Ticket contract deployed at:", address(ticket));

        vm.stopBroadcast();
    }
}

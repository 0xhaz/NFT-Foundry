// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BasicNFT} from "../src/BasicNFT.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNft is Script {
    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function run() external {
        address contractAddress = DevOpsTools.get_most_recent_deployment("BasicNFT", block.chainid);
        mintNftOnContract(contractAddress);
    }

    function mintNftOnContract(address _contractAddress) public {
        vm.startBroadcast();
        BasicNFT(_contractAddress).mintNft(PUG);
        vm.stopBroadcast();
    }
}

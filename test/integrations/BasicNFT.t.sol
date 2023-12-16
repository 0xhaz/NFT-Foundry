// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {BasicNFT} from "../../src/BasicNFT.sol";
import {DeployBasicNft} from "../../script/BasicNFT.s.sol";

contract BasicNFTTest is Test {
    DeployBasicNft deployer;
    BasicNFT public basicNft;
    address public USER = makeAddr("user");
    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function test_Name_Is_Correct() public view {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    function test_Can_Mint_And_Have_A_Balance() public {
        vm.prank(USER);
        basicNft.mintNft(PUG);

        assert(basicNft.balanceOf(USER) == 1);
        assert(basicNft.ownerOf(0) == USER);
        assert(keccak256(abi.encodePacked(basicNft.tokenURI(0))) == keccak256(abi.encodePacked(PUG)));
    }
}

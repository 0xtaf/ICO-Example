// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./IDuo.sol";

contract Tres is ERC20, Ownable {
    uint256 public constant tokenPrice = 0.001 ether;

    // 10 tokens
    uint256 public constant tokensPerNFT = 10 * 10**18;

    uint256 public constant maxTokenSupply = 10000 * 10**18;

    IDuo ExampleNFT;

    mapping(uint256 => bool) public tokenIdsClaimed;

    constructor(address _exampleNFTContract) ERC20("Example Token", "ETT") {
        ExampleNFT = IDuo(_exampleNFTContract);
    }

    receive() external payable {}

    fallback() external payable {}
}

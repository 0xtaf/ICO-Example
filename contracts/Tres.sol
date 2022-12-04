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

    function mint(uint256 amount) public payable {
        uint256 _requiredAmount = tokenPrice * amount;

        require(msg.value >= _requiredAmount, "not enough balance");
        require(
            (totalSupply() + amount * 10**18) <= maxTokenSupply,
            "exceeds max token supply"
        );
        _mint(msg.sender, amount * 10**18);
    }

    function claim() public {
        uint256 balance = ExampleNFT.balanceOf(msg.sender);
        require(balance > 0, "you don't have example nfts");

        uint256 amount = 0;

        for (uint256 i = 0; i < balance; i++) {
            uint256 tokenId = ExampleNFT.tokenOfOwnerByIndex(msg.sender, i);

            if (!tokenIdsClaimed[tokenId]) {
                amount++;
                tokenIdsClaimed[tokenId] = true;
            }
        }

        require(amount > 0, "you have already claimed all the tokens");

        _mint(msg.sender, amount * tokensPerNFT);
    }

    function withdraw() public onlyOwner {
        uint256 amount = address(this).balance;
        require(amount > 0, "contract balance is empty");

        address _owner = owner();
        (bool sent, ) = _owner.call{value: amount}("");
        require(sent, "failed");
    }

    receive() external payable {}

    fallback() external payable {}
}

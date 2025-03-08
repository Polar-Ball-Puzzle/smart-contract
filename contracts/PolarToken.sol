// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GameToken is ERC20, ERC20Burnable, Ownable {
    constructor() ERC20("Polar Token", "POT") {
        _mint(msg.sender, 1000000 * 10 ** decimals()); // Initial supply
    }
    
    function rewardPlayer(address player, uint256 amount) external onlyOwner {
        _mint(player, amount);
    }
}
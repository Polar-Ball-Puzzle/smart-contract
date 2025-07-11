// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20Mock is ERC20 {
    uint8 private _customDecimals;

    constructor(
        string memory name,
        string memory symbol,
        address initialAccount,
        uint256 initialSupply,
        uint8 customDecimals
    ) ERC20(name, symbol) {
        _mint(initialAccount, initialSupply);
        _customDecimals = customDecimals;
    }

    function decimals() public view override returns (uint8) {
        return _customDecimals;
    }
}

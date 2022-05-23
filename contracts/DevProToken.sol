//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import "hardhat/console.sol";

contract DevProToken is ERC20 {
    constructor(string memory _name, string memory _symbol)
        public
        ERC20(_name, _symbol)
    {
        _mint(msg.sender, amount);
    }
}

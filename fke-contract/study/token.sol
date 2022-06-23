// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract myToken is ERC20 {
    constructor(string memory name_, string memory symbol_, uint256 totalsuppy) ERC20(name_, symbol_) {
        _mint(msg.sender, totalsuppy*10**18);
    }
}

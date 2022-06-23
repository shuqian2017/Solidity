// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (token/ERC1155/ERC1155.sol)

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";


contract ArcNFT is ERC1155 {

    uint256 public constant Bronze = 0;
    uint256 public constant Silver = 1;
    uint256 public constant Golden = 2;
    uint256 public constant Diamond = 3;

    constructor() ERC1155("https://storage.arcdex.io/nft/static/{id}.json") {
        _mint(msg.sender, Bronze, 4000, "");
        _mint(msg.sender, Silver, 3000, "");
        _mint(msg.sender, Golden, 2000, "");
        _mint(msg.sender, Diamond, 1000, "");
    }

    function uri(uint256 _tokenid) override public pure returns (string memory) {
        return string(
            abi.encodePacked(
                "https://storage.arcdex.io/nft/static/",
                Strings.toString(_tokenid),
                ".json"
            )
        );
    }
}
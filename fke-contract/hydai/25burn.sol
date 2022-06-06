pragma solidity ^0.4.25;

import "./21ERC20.sol";

contract Burnable is ERC20{

    function burn(uint256 tokens) public returns (bool) {
        // 检查够不够burn
        require(tokens <= _balances[msg.sender]);
        // 减少total supply
        _totalSupply = _totalSupply.sub(tokens);
        // 减少msg.sender balance
        _balances[msg.sender] = _balances[msg.sender].sub(tokens);

        emit Burn(msg.sender, tokens);
        emit Transfer(msg.sender, address(0), tokens);
        return true;
    }
}
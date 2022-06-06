pragma solidity ^0.4.25;

import "./library/SafeMath.sol";
import "./library/IERC20.sol";

contract ERC20 is IERC20 {
    using SafeMath for uint256;

    uint256 private _totalSupply;
    mapping(address => uint256) _balances;
    mapping(address => mapping(address => uint256)) _approve;

    // 所有存在的Token数量
    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    // 读取 tokenOwner 这个address 所持有的Token数量
    // address => uint256
    function balanceOf(address tokenOwner) external view returns (uint256 balance) {
        return _balances[tokenOwner];
    }

    // 从 msg.sender 转 tokens 个 Token给 to 这个address
    // msg.sender  --> tokens --> to
    function transfer(address to, uint256 tokens) external returns (bool success) {
        _balances[msg.sender] = _balances[msg.sender].sub(tokens);
        _balances[to] = _balances[to].add(tokens);

        emit Transfer(msg.sender, to, tokens);
        return true;
    }

    // 得到 tokenOwner 授权给 spender 使用的 Token 剩余数量
    function allowance(address tokenOwner, address spender) external view returns (uint256 remaining) {
        return _approve[tokenOwner][spender];
    }

    // tokenOwner -> spender -> tokens
    // address => address => uint256
    // msg.sender 授权给 spender 可以使用自己的 tokens 个 Token
    function approve(address spender, uint256 tokens) external returns (bool success) {
        _approve[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    // 将 tokens 个 Token 从 from 转到 to
    function transferFrom(address from, address to, uint256 tokens) external returns (bool success) {
        _approve[from][msg.sender] = _approve[from][msg.sender].sub(tokens);
        _balances[from] = _balances[from].sub(tokens);
        _balances[to] = _balances[to].add(tokens);
        emit Transfer(from, to, tokens);
        return true;
    }
}

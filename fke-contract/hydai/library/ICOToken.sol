pragma solidity ^0.4.25;

import "./SafeMath.sol";
import "./IERC20.sol";

contract ICOToken is IERC20 {
    using SafeMath for uint256;

    string mName = "fke token";
    uint8 mDecimals = 18;
    string mSymbol = "FKE"; 

    uint256  mTotalSupply = 0;
    mapping(address => uint256) mBalances;
    mapping(address => mapping(address => uint256)) mApprove;

    constructor(
        string name,
        uint8 decimals,
        string symbol,
        uint256 totalSupply
    ) public {
        mName = name;
        mDecimals = decimals;
        mSymbol = symbol;
        mTotalSupply = totalSupply;
        mBalances[msg.sender] = mBalances[msg.sender].add(mTotalSupply);
        emit Transfer(address(this), msg.sender, mTotalSupply);
    }

    // 所有存在的Token数量
    function totalSupply() external view returns (uint256) {
        return mTotalSupply;
    }

    // 读取 tokenOwner 这个address 所持有的Token数量
    // address => uint256
    function balanceOf(address tokenOwner) external view returns (uint256 balance) {
        return mBalances[tokenOwner];
    }

    // 从 msg.sender 转 tokens 个 Token给 to 这个address
    // msg.sender  --> tokens --> to
    function transfer(address to, uint256 tokens) external returns (bool success) {
        return _transfer(msg.sender, to, tokens);
    }

    // 得到 tokenOwner 授权给 spender 使用的 Token 剩余数量
    function allowance(address tokenOwner, address spender) external view returns (uint256 remaining) {
        return mApprove[tokenOwner][spender];
    }

    // tokenOwner -> spender -> tokens
    // address => address => uint256
    // msg.sender 授权给 spender 可以使用自己的 tokens 个 Token
    function approve(address spender, uint256 tokens) external returns (bool success) {
        mApprove[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    // 将 tokens 个 Token 从 from 转到 to
    function transferFrom(address from, address to, uint256 tokens) external returns (bool success) {
        mApprove[from][msg.sender] = mApprove[from][msg.sender].sub(tokens);
     
        return _transfer(from, to, tokens);
    }

    // 公共部分抽离为单独方法，供内部调用
    function _transfer(address from, address to, uint256 tokens) internal returns (bool success) {
        mBalances[from] = mBalances[from].sub(tokens);
        mBalances[to] = mBalances[to].add(tokens);
        emit Transfer(from, to, tokens);
        return true;
    }

    function name() public constant returns (string) {
        return mName;
    }

    function decimals() public constant returns (uint8) {
        return mDecimals;
    }

    function symbol() public constant returns (string) {
        return mSymbol;
    }
}

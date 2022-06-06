pragma solidity ^0.4.25;

interface IERC20 {

    // 所有存在的 Token 数量 
    function totalSupply() external view returns (uint256);

    // 读取 tokenOwner 这个 address 所持有的 Token 数量
    function balanceOf(address tokenOwner) external view returns (uint256 balance);

    // 从 msg.sender 转 tokens 个 Token 给 to 这个 address
    function transfer(address to, uint256 tokens) external returns (bool success);

    // 得到 tokenOwner 授权给 spender 使用的 Token 剩余数量 
    function allowance(address tokenOwner, address spender) 
        external view returns (uint256 remaining);

    // msg.sender 授权给 spender 可使用自己的 tokens 个 Token
    function approve(address spender, uint256 tokens) external returns (bool success);

    // 将 tokens 个 Token 从 from 转到 to 
    function transferFrom(address from, address to, uint256 tokens) 
        external returns (bool success);

    event Transfer(
        address indexed from,
        address indexed to,
        uint256 tokens
    );

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 tokens
    );
}
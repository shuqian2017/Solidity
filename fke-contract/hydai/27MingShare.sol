pragma solidity ^0.4.25;

import "./library/SafeMath.sol";

contract MiningShare {

    using SafeMath for uint256;

    // 召集人
    address private owner = 0x0;
    // 召集人设定模募资时间
    uint private closeBlock = 0;
    // 投资者：
    //  1. 投资金额
    mapping(address => uint) private userRMB;
    //  2. 提取金额
    mapping(address => uint) private userWithdraw;
    // 记录参数：
    //  1. 总投资金额
    uint public totalRMB = 0;
    //  2. 总提取金额
    uint public totalWithdraw = 0;

    // 召集人功能
    constructor() public {
        owner = msg.sender;
        closeBlock = block.number + 2000;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier onlyShareHolder() {
        require(userRMB[msg.sender] != 0);
        _;
    }

    // 在募资结束之前
    modifier beforeCloseBlock() {
        require(block.number <= closeBlock);
        _;
    }

    modifier afterCloseBlock() {
        require(block.number > closeBlock);
        _;
    }

    // 开始之前可以加仓
    function CapitalIncrease(address account, uint RMB) onlyOwner beforeCloseBlock public {
        userRMB[account] = userRMB[account].add(RMB);
        totalRMB = totalRMB.add(RMB);
    }

    // 开始之前可以减仓
    function CapitalDecrease(address account, uint RMB) onlyOwner beforeCloseBlock public {
        userRMB[account] = userRMB[account].sub(RMB);
        totalRMB = totalRMB.sub(RMB);
    }

    function MyTotalRMB() public constant onlyShareHolder returns (uint) {
        return userRMB[msg.sender];
    }

    function MyTotalWithdraw() public constant onlyShareHolder afterCloseBlock returns (uint) {
        return userWithdraw[msg.sender];
    }

    function TotalMined() public constant  onlyShareHolder afterCloseBlock returns (uint) {
        return totalWithdraw.add(address(this).balance);
    }

    function Withdraw(uint tokens) public onlyShareHolder afterCloseBlock returns (bool) {
        uint totalMined = totalWithdraw.add(address(this).balance);
        // totalMined * userRMB / totalRMB - userWithdraw;
        uint userCanWithdraw = totalMined.mul(userRMB[msg.sender].div(totalRMB)).sub(userWithdraw[msg.sender]);
        require(tokens <= userCanWithdraw);
        userWithdraw[msg.sender].add(tokens);
        totalWithdraw.add(tokens);
        msg.sender.transfer(tokens);
        return true;
    }
}
pragma solidity ^0.4.25;

contract Reward {

    struct RewardInfo {
        address[] rewarders;
        mapping (address => uint) ledger;
    }
    mapping (address => RewardInfo) RewardHistory;

    event LogReward(address anchor, address rewarder, string nickname, 
        uint value, string message);

    event LogListRewardInfo(address anchor, address user, uint value);

    // 在捐献功能里面把观众的昵称 & 消息 & 钱推送到log上面，永远保存。
    function reward(address _anchor, string _nickname, string _message) public payable {
        require(msg.value > 0, "reward value is error.");
        _anchor.transfer(msg.value);

        if (RewardHistory[_anchor].ledger[msg.sender] ==0) {
            RewardHistory[_anchor].rewarders.push(msg.sender);
        }
        RewardHistory[_anchor].ledger[msg.sender] += msg.value;

        emit LogReward(_anchor, msg.sender, _nickname, msg.value, _message);
    }

    function getRewarderList() public view returns (address[]) {
        return RewardHistory[msg.sender].rewarders;
    }

    function listRewarderInfo() public {
        for (uint i = 0; i < RewardHistory[msg.sender].rewarders.length; i++) {
            address user = RewardHistory[msg.sender].rewarders[i];
            emit LogListRewardInfo(msg.sender, user, RewardHistory[msg.sender].ledger[user]);
        }
    }
}
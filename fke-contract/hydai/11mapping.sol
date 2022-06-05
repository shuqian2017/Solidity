pragma solidity ^0.4.25;

contract Reward {
    mapping(address => uint) public ledger;
    mapping(address => bool) public rewarder;
    address[] public rewarderlist;

    function isRewarder(address pAddr) internal view returns (bool) {
        return rewarder[pAddr];
    }

    function reward() public payable {
        if (msg.value >= 1 ether) {
            if (!isRewarder(msg.sender)) {
                rewarder[msg.sender] = true;
                rewarderlist.push(msg.sender);
            }
            ledger[msg.sender] += msg.value;
        }
        else {
            revert("reward is amount < 1 ether");
        }
    }
}
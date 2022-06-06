pragma solidity ^0.4.25;

contract Reward {

    /*  TODO: Reward Record
        anchor => rewarder
    */

    event LogReward(address anchor, address rewarder, string nickname, 
        uint value, string message);

    function reward(address _anchor, string _nickname, string _message) public payable {
        _anchor.transfer(msg.value);
        emit LogReward(_anchor, msg.sender, _nickname, msg.value, _message);
    }
}
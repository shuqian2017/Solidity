pragma solidity ^0.4.25;

contract Ownable {
    address private owner;

    constructor() internal {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(isOwner());
        _;
    }

    function isOwner() public view returns (bool) {
        return owner == msg.sender;
    }
}

contract Main is Ownable {

    string public name = "法外狂徒 - 张三";

    function modifyName(string _name) public onlyOwner {
        name = _name;
    }
}
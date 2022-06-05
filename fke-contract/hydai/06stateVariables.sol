pragma solidity ^0.4.25;

contract StateVariables {
    string name;
    uint public rename_counter;
    address owner;

    constructor() public {
        /* Inittailize default state. */
        name = "unknown";
        owner = msg.sender;
        rename_counter = 0;
    }

    modifier checkOwner(address _addr) {
        require(_addr == owner, "Address is not the owner.");
        rename_counter += 1;
        _;
    }

    function setName(string _name) public checkOwner(msg.sender) returns (string) {
        name = _name;
        return name;
    }

    function getName() public view returns (string) {
        return name;
    }
}
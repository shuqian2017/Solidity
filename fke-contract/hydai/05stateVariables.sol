pragma solidity ^0.4.25;

contract StateVariables {
    string name;
    address owner;

    constructor() public {
        /* Initailize default state. */
        name = "unknown";
        owner = msg.sender;
    }

    function setName(string _name) public returns (string) {
        /* Only owner has the permission to modify its name. */
        if (msg.sender == owner) {
            name = _name;
        } else {
            revert("Permission denied.");
        }
        return name;
    }

    function getName() public view returns (string) {
        return name;
    }
}
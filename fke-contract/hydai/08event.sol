pragma solidity ^0.4.25;

contract Test {
    string information;
    uint balance;

    event LogCreate(string information, uint balance);
    event LogCreateIndex(string indexed information, uint indexed balance);

    constructor() public {
        information = "default";
        balance = 100;
        /* Keccak-256: LogCreate(string,uint256) */
        emit LogCreate(information, balance);
        emit LogCreateIndex(information, balance);
    }
}
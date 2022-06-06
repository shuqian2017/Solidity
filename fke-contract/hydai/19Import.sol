pragma solidity ^0.4.25;

import "./library/set.sol";

contract Main {

    using Set for Set.Data;
    Set.Data mySet;

    function insert(int key) public returns (bool) {
        return mySet.Insert(key);
    }

    function Remove(int key) public returns (bool) {
        return mySet.Remove(key);
    }

    function Contain(int key) public view returns (bool) {
        return mySet.Contain(key);
    }
}
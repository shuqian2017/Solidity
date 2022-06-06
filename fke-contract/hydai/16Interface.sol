 pragma solidity ^0.4.25;

 interface Animal {
    function run(uint speed) external returns (uint);
 }

 contract Cat is Animal {
    function run(uint speed) public returns (uint distance) {
        return speed * 2;
    }
 }

 contract Dog is Animal {
    function run(uint speed) public returns (uint distance) {
        return speed * 5;
    }
 }
 
// SPDX-License-Identifier: GPL-3.0
pragma solidity  ^0.7.0;

/*
* 第四部分： 通过new创建合约
* 加盐的合约例子
*/

contract D {
    uint public x;
    constructor(uint a) {
        x = a;
    }
}

contract C {
    function createDSalted(bytes32 salt, uint arg) public {
        /// 这个复杂的表达式只是告诉我们，如何预先计算地址。
        /// 这里仅仅用来说明
        /// 实际上,你仅仅需要 `new D{salt: salt}(arg)`.
        address predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this),
            salt,
            keccak256(abi.encodePacked(
                type(D).creationCode,
                arg
            ))
        )))));

        D d = new D{salt: salt}(arg);
        require(address(d) == predictedAddress);
    }
}
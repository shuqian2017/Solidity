// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.7.0 <0.9.0;

/*
* 第四部分： 通过new创建合约
* new创建合约的例子
*/

contract D {
    uint public x;
    constructor(uint a) payable {
        x = a;
    }
}

contract C {
    D d = new D(4);     // 将作为合约C 构造函数的一部分执行

    function createD(uint arg) public {
        D newD = new D(arg);
        newD.x();
    }

    function createAndEndowD(uint arg, uint amount) public payable {
        // 随合约的创建发送ether
        D newD = (new D){value: amount }(arg);
        newD.x();
    }
}

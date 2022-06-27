// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

/*
* 第四部分： 算术运算检查模式
* uncheck的例子
*/

contract C {
    function f(uint a, uint b) pure public returns (uint) {
        // 减法溢出会返回"截断"的结果
        unchecked { return a - b; }
    }

    function g(uint a, uint b) pure public returns (uint) {
        // 溢出会抛出异常
        return a - b;
    }
}
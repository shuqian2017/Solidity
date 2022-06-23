// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.5;

/*
* 第三部分： 基本类型转换
* 显式转换的例子
*/

contract C {
    bytes s = "abcdefgh";
    function f(bytes calldata c, bytes memory m) public view returns (bytes16, bytes3) {
        require(c.length == 16, "error: lenght is error.");
        bytes16 b = bytes16(m);         // 如果m长度大于16，则会发生截断
        b = bytes16(s);                 // 在右边填充，结果是 "abcdefgh\0\0\0\0\0\0\0\0"
        bytes3 b1 = bytes3(s);          // 截断，b1等于“abc”
        b = bytes16(c[:8]);             // 也用零填充
        return (b, b1);
    }
}
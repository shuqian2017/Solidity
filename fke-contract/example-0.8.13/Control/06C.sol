// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.4.22 <0.9.0;

/*
* 第四部分： 赋值
* 数组和结构体复杂性的例子
*/

contract C {
    uint[20] x;

    function f() public {
        g(x);
        h(x);
    }

    function g(uint[20] memory y) internal pure  {
        y[2] = 3;
    }

    function h(uint[20] storage y) internal {
        y[3] = 4;
    }
}

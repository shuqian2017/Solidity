// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.4.16 <0.9.0;

/*
* 第三部分： 引用类型
* 创建内存数组的例子
*/

contract TX {

    function f(uint len) public pure returns (uint[] memory array) {
        uint[] memory a = new uint[](7);
        bytes memory b = new bytes(len);

        assert(a.length == 7);
        assert(b.length == len);

        a[6] = 8;
        return a;
    }
}
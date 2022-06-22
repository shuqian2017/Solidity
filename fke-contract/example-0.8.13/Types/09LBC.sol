// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

/*
* 第三部分： 引用类型
* 数组常量的例子
*/

contract LBC {

    function f() public pure {
        g([uint(1), 2, 3]);

        // 这一行引发了一个类型错误，因为 unint[3] memory
        // 不能转换成 uint[] memory。
        // uint[] x = [uint(1), 3, 4]; 
    }

    function g(uint[3] memory array) public pure returns (uint[3] memory) {
        // ...
        uint[3] memory x = array;
        return x;
    }
}


contract C {

    function f() public pure returns (uint24[2][4] memory) {
        uint24[2][4] memory x = [[uint24(0x1), 1], [0xffffff, 2], [uint24(0xff), 3], [uint24(0xffff), 4]];
        // 下面代码无法工作,因为没有匹配内部类型
        // uint[2][4] memory x = [[0x1, 1], [0xffffff, 2], [0xff, 3], [0xffff, 4]];
        return x;
    }

    /*
    * 初始化动态长度的数组，则必须显示给各个元素赋值
    */
    function g() public pure {
        uint[] memory x = new uint[](3);
        x[0] = 1;
        x[1] = 3;
        x[2] = 4;
    }
}
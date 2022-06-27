// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.4.0 <0.9.0;

/*
* 第四部分： 函数调用
* 具名调用和匿名函数参数的例子
*/

contract C {

    mapping(uint => uint) data;
    // 参数列表必须按照名称与函数声明中的参数列表相符,但是可以按任意顺序排列 
    function f() public {
        set({value: 2, key: 3});
    }

    function set(uint key, uint value) public {
        data[key] = value;
    }
}
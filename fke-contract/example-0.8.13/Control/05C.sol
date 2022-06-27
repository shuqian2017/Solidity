// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.5.0 <0.9.0;

/*
* 第四部分： 赋值
* 返回多值的例子
*/

contract C {
    uint index;

    function f() public pure returns (uint, bool, uint) {
        return (7, true, 2);
    }

    function g() public {
        // 基于返回的元组来声明变量并赋值
        (uint x, bool b, uint y) = f();
        // 交换两个值的通用窍门 ——  但不适用于非值类型的存储(storage)变量
        (x, b, y) = (y, b, x);
        // 元组的末尾元素可以省略(这也适用于变量声明)
        (index,,) = f();    // 设置index 为 7
    }
}

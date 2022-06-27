// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.5.0 <0.9.0;

/*
* 第四部分： 作用域和声明
* 数组和结构体复杂性的例子
*/


// 此示例不会出现警告，因为2个变量名字虽然一样，但却在不同的作用域里
contract C {
    function minimalScoping() pure public {
        {   uint same;
            same = 1;
        }


        {
            uint same;
            same = 3;
        }
    }
}


contract D {
    function f() pure public returns (uint) {
        uint x = 1;
        {
            x = 2;  // 这个赋值会影响在外层声明的变量
            uint x;
        }
        return x;   // x has value 2
    }
}


// 0.5.0 之后此种写法会导致编译报错
contract E {
    function f() pure public returns (uint) {
        x = 2;      // 0.5.0 之后此种写法会导致编译报错
        uint x;
        return x;
    }
}

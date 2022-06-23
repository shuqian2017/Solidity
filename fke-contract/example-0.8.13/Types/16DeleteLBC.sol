// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.0 <0.9.0;

/*
* 第三部分： 操作符
* delete的例子
*/

contract DeleteLBC {

    uint data;
    uint[] dataArray;

    function f() public {
        uint x = data;      
        delete x;       // 将 x 设为0，并不影响数据
        delete data;    // 将data 设为0，并不影响 x，因为他们任然有个副本
        uint[] storage y = dataArray;
        delete dataArray;
        // 将 dataArray.length 设置为0，但由于uint[]是一个复杂的对象, y也将受到影响,
        // 因为它是一个存储位置是storage 的对象别名。
        // 另一方面： `delete y` 是非法的，引用了 storage 对象的局部变量只能由已有的storage 对象赋值。 
        assert(y.length == 0);
    }
}
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.9.0;

/*
* 第三部分： 引用类型
* 数据位置与赋值行为例子
*/

contract Tiny {

    uint[] x;   // x 的数据存储位置是 storage, 位置可以忽略

    // memoryArray 的数据存储位置是 memory
    function f(uint[] memory memoryArray) public {
        x = memoryArray;  // 将整个数组拷贝到storage中, 可行
        uint[] storage y = x;  // 分配一个指针(其中 y的数据存储位置是storage), 可行
        y[7];   // 返回第8个元素, 可行
        y.pop();  // 通过 y 修改 x, 可行
        delete x;  // 清除数组, 同时修改 y, 可行

        // 下面的就不可行了；需要在 storage 中创建新的未命名的临时数组，
        // 但 storage 是“静态”分配的：
        // y = memoryArray;
        // 下面这一行也不可行，因为这会“重置”指针，
        // 但并没有可以让它指向的合适的存储位置。
        // delete y;
        g(x);   // 调用 g 函数, 同时移交对 x 的引用
        h(x);   // 调用 h 函数, 同时在memory 中创建一个独立的临时拷贝
    }

    function g(uint[] storage) internal pure {}
    function h(uint[] memory) public pure {}
}

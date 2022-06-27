// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.0 <0.9.0;

/*
* 第五部分： getter函数
* 数组类型状态变量的例子
*/

contract arrayExample {

    // public 状态变量
    uint[] public myArray;

    constructor() {
        myArray = [1, 2, 3 ,4 ,5, 6];
    }

    // 指定生成的Getter 函数
    // 获取数组的单个元素
    // function myArray(uint i) public view returns (uint) {
    //     return myArray[i];
    // }

    // 返回整个数组
    function getArray() public view returns (uint[] memory) {
        return myArray;
    }
}



contract Complex {
    struct Data {
        uint a;
        bytes3 b;
        mapping (uint => uint) map;
        uint[3] c;
        uint[] d;
        bytes e;
    }
    mapping (uint => mapping (bool => Data[])) public data;

    
    // 生成的getter函数 : 结构体内的映射和数组(byte数组除外)被省略,因为没有好办法为其提供一个键
    // function data(uint arg1, bool arg2, uint arg3) public returns (uint a, bytes3 b, bytes memory e) {
    //     a = data[arg1][arg2][arg3].a;
    //     b = data[arg1][arg2][arg3].b;
    //     e = data[arg1][arg2][arg3].e;
    // }
}


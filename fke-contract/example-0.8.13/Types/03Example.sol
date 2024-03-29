// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.4 <0.9.0;

/*
* 第三部分： 函数类型
* 使用成员的例子
*/

contract Example {
    function f() public payable returns (bytes4) {
        assert(this.f.address == address(this));
        return this.f.selector;
    }

    function g() public {
        this.f{gas: 10, value: 800}();
    }
}

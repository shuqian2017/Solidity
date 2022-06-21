// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.12;

/*
* 第三部分： 引用类型
* 函数`bytes.concat`和`string.concat`例子
*/

contract C {

    string s = "Storage";

    function f(bytes calldata bc, string memory sm, bytes16 b) public view returns(bytes memory B) {
        string memory concatString = string.concat(s, string(bc), "Literal", sm);
        assert((bytes(s).length + bc.length + 7 + bytes(sm).length) == bytes(concatString).length);

        bytes memory concatBytes = bytes.concat(bytes(s), bc, bc[:2], "Literal", bytes(sm), b);
        assert((bytes(s).length + bc.length + 2 + 7 + bytes(sm).length + b.length) == concatBytes.length);
        return concatBytes;
    }
}
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16  <0.9.0;

/*
* 第三部分： 函数类型
* 使用内部函数类型的例子
*/

library ArrayUtils {
    // 内部函数可以在内部库函数中使用,
    // 因为它们会成为同一代码上下文的一部分
    function map(uint[] memory self, function (uint) pure returns (uint) f)
        internal pure returns (uint[] memory r) {
            r = new uint[](self.length);
            for (uint i = 0; i < self.length; i++) {
                r[i] = f(self[i]);
            }
        }

    function reduce(uint[] memory self, function (uint, uint) pure returns (uint) f) 
        internal pure returns (uint r) {
            r = self[0];
            for (uint i = 1; i < self.length; i++) {
                r = f(r, self[i]);
            }
        }

    function range(uint length) internal pure returns (uint[] memory r) {
        r = new uint[](length);
        for (uint i = 0; i < r.length; i++) {
            r[i] = i;
        }
    }
}

/*
* n = 0是, y = 0
* 当n >= 1; 有y = n² + (n-1)² + (n-2)² + ... + 1
*/
contract Pyramid {

    using ArrayUtils for *;
    function pyramid(uint m) public pure returns (uint) {
        return ArrayUtils.range(m).map(square).reduce(sum);
    }

    function square(uint x) internal pure returns (uint) {
        return x * x;
    }

    function sum(uint x, uint y) internal pure returns (uint) {
        return x + y;
    }
}



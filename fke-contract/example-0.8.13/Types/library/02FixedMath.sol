// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.8;

 // 使用用户定义的值类型表示18小数，256位宽的固定点类型
 type UFixed256x18 is uint256;

 /// 最小库在 UFixed256x18 上进行固定点操作
 library FixedMath {

    uint constant multiplier = 10**18;

    /// 添加两个 UFixed256x18 数字。依靠检查 uint256 上的算术来恢复溢出
    function add(UFixed256x18 a, UFixed256x18 b) internal pure returns (UFixed256x18) {
        return UFixed256x18.wrap(UFixed256x18.unwrap(a) + UFixed256x18.unwrap(b));
    }

    /// 乘以 UFixed256x18 和 uint256. 依靠检查在uint256上进行算术来恢复溢出
    function mul(UFixed256x18 a, uint256 b) internal pure returns (UFixed256x18) {
        return UFixed256x18.wrap(UFixed256x18.unwrap(a) * b);
    }

    function floor(UFixed256x18 a) internal pure returns (uint256) {
        return UFixed256x18.unwrap(a) / multiplier;
    }

    /// 将 uint256 变成相同值的 UFixed256x18. 如果整数太大则进行恢复
    function toUFixed256x18(uint256 a) internal pure returns (UFixed256x18) {
        return UFixed256x18.wrap(a * multiplier);
    }
 }
 
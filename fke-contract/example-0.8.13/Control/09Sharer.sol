// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.9.0;

/*
* 第四部分： 错误以及异常处理
* require的例子
*/

contract Sharer {
    function sendHalf(address payable addr) public payable returns (uint balance) {
        require(msg.value % 2 == 0, "Event value required.");
        uint balanceBeforeTransfer = address(this).balance;
        addr.transfer(msg.value / 2);

        // 由于转账函数在失败时爆出异常并且不会调用到以下代码，因此我们应该没有办法检查
        assert(address(this).balance  == balanceBeforeTransfer - msg.value / 2);
        return address(this).balance;
    }
}


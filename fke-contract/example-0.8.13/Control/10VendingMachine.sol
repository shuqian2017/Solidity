// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.4 <0.9.0;

/*
* 第四部分： 错误以及异常处理
* revert的例子
*/

contract vendingMachine {
    address  owner = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    error Unauthorized();

    function buy(uint amount) public payable {
        if (amount > msg.value / 2  ether)
            revert("Not engough Ether provided.");
        // 只要附加参数没有额外效果, 使用结果是等价的
        require(
            amount <= msg.value / 2 ether,
            "Not engough Ether provided."
        );
        // 以下执行购买逻辑
    }

    function withdraw() public {
        if (msg.sender != owner)
            revert Unauthorized();

        payable(msg.sender).transfer(address(this).balance);
    }
}

// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.6.2 <0.9.0;

/*
* 第四部分： 函数调用
* 外部函数调用的例子
*/

contract InfoFeed {

    function info() public payable returns (uint ret) { return 42;} 
}


contract Consumer {
    InfoFeed feed;
    function setFeed(InfoFeed addr) public { feed = addr; }
    function callFeed() public { feed.info{value: 10, gas: 800}(); }
}

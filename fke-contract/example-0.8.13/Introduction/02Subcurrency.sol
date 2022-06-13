// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract Coin {

    // 关键字 `public` 让这些变量可以从外部读取
    address public minter;
    mapping(address => uint) public balances;

    // 轻客户端可以通过事件针对变化作出高效的反应
    event Sent(address from, address to, uint amount);

    // 这是构造函数，只有当合约创建时才运行
    constructor() {
        minter = msg.sender;
    }

    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount;
    }

    /*
    *   允许您提供有关的错误信息   
    *   为什么操作失败。他们被返回
    *   函数的调用者
    */
    error InsufficientBalance(uint requested, uint available);

    function send(address receiver, uint amount) public {
        if (amount > balances[msg.sender])
            revert InsufficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });

        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}
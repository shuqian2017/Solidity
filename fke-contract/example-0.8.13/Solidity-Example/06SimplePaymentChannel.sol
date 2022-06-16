// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract SimplePaymentChannel {

    address payable public sender; // The account sending payments.
    address payable public recipient; // The account receiving the payments.
    uint256 public expiration;  // Timeout in case the recipient never closes.

    constructor(address payable recipientAddress, uint256 duration) payable {
        sender = payable(msg.sender);
        recipient = recipientAddress;
        expiration = block.timestamp + duration;
    }

    function isValidSignature(uint256 amount, bytes memory signature) internal view returns (bool) {
        bytes32 message = prefixed(keccak256(abi.encodePacked(this, amount)));
        // 检查签名是否来自 sender
        return recoverSigner(message, signature) == sender;
    }

    /// 接收方`recipient` 可以随时关闭支付通道
    /// 通过提交一个由`sender`签名的金额。接收方`recipient`将能得到那个数量的金额
    /// 然后剩余的金额将返还给`sender`
    function close(uint256 amount, bytes memory signature) external {
        require(msg.sender == recipient);
        require(isValidSignature(amount, signature));
        recipient.transfer(amount);
        selfdestruct(sender);
    }

    /// `sender`可以随时延长过期时间
    function extend(uint256 newExpiration) external {
        require(msg.sender == sender);
        require(newExpiration > expiration);
        expiration = newExpiration;
    }

    /// 如果过期时间已到,而收款人没有关闭通道,可执行此函数,销毁合约并返还余额
    function claimTimeout() external {
        require(block.timestamp > expiration);
        selfdestruct(sender);
    }

    /// 下面所有的功能仅从本章中获取
    /// 创建和验证签名 章节
    function splitSignature(bytes memory sig) internal pure returns (uint8 v, bytes32 r, bytes32 s) {
        require(sig.length == 65);
        assembly {
            // 第一部分的32个字节，在长度前缀之后
            r := mload(add(sig, 32))
            // 第二部分的32个字节
            s := mload(add(sig, 64))
            // 最终字节（在接下来的32个字节的第一个字节）
            v := byte(0, mload(add(sig, 96)))
        }
        return (v, r, s);
    }

    function recoverSigner(bytes32 message, bytes memory sig) internal pure returns (address) {
        (uint8 v, bytes32 r, bytes32 s) = splitSignature(sig);
        return ecrecover(message, v, r, s);
    }

    function prefixed(bytes32 hash) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
    }
}
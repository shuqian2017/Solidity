// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 < 0.9.0;

contract ReceiverPays {

    address owner = msg.sender;
    mapping(uint256 => bool) usedNonces;

    constructor() payable {}

    // 收款方认领付款
    function claimPayment(uint256 amount, uint256 nonce, bytes memory signature) external {
        require(!usedNonces[nonce]);
        usedNonces[nonce] = true;

        // 重建在客户端签名的信息
        bytes32 message = prefixed(keccak256(abi.encodePacked(msg.sender, amount, nonce, this)));
        require(recoverSigner(message, signature) == owner);
        payable(msg.sender).transfer(amount);
    }

    /// 销毁合约并收回剩余的资金。
    function kill() external {
        require(msg.sender == owner);
        selfdestruct(payable(msg.sender));
    }

    /// 第三方方法, 分离签名信息的 v r s
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

    /// 加入一个前缀, 因为在eth_sign签名的时候会加上。
    function prefixed(bytes32 hash) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
    }
}

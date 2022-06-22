// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.5 <0.9.0;

/*
* 第三部分： 引用类型
* 数组切片的例子
*/

contract Proxy {

    // 被当前合约管理的 客户端合约地址
    address client;

    constructor(address client_) {
        client = client_;
    }

    event log(bytes4 Sig, address Owner, bool Status, bytes4 Sig_);

    // 在进行参数验证之后, 转发到由client实现的 `setOwner(address)`
    function forward(bytes calldata payload) external  {
        bytes4 sig = bytes4(payload[:4]);

        // 由于截断行为,与执行bytes4(payload)是相同的
        // bytes4 sig = bytes4(payload);

        address owner;
        bytes4 sig_ = bytes4(keccak256("setOwner(address)"));
        if (sig == sig_) {  
            owner = abi.decode(payload[4:], (address));      
            require(owner != address(0), "Address of owner cannot be zero.");
        }
        (bool status,) = client.delegatecall(payload);
        require(status, "Forwarded call failed.");

        emit log(sig, owner, status, sig_);

    }

    function keccak256Encode(string calldata str) public pure returns(bytes32) {
        return keccak256(abi.encodePacked(str));
    }

    /// bytes32 转 bytes4 
    function toBytes(bytes32  payload) public pure returns (bytes4) {
        return bytes4(abi.encodePacked(payload));
    }

}
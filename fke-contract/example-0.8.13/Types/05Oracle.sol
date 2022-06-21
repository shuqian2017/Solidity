// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

/*
* 第三部分： 函数类型
* 使用外部函数类型的例子
*/

contract Oracle {

    struct Request {
        bytes data;
        function(uint) external callback;
    }

    Request[] private requests;
    event NewRequest(uint);

    function query(bytes memory data, function (uint) external callback) public {
        requests.push(Request(data, callback));
        emit NewRequest(requests.length - 1);
    }

    function reply(uint requestID, uint response) public {
        // 这里检查回复来自可信来源
        requests[requestID].callback(response);
    }
}

contract OracleUser {

    Oracle constant private ORACLE_CONST = Oracle(address(0xd9145CCE52D386f254917e481eB44e9943F39138));
    uint private exchangeRate;

    function buySomething() public {
        ORACLE_CONST.query("USD", this.oracleResponse);
    }

    function oracleResponse(uint response) public {
        require(msg.sender == address(ORACLE_CONST), "Only oracle can call this.");
        exchangeRate = response;
    }
}

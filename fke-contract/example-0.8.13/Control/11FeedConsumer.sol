// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.1;

/*
* 第四部分： 错误以及异常处理
* try/catch的例子
*/

interface DataFeed { function getData(address token) external returns (uint value); }

contract FeedConsumer {
    DataFeed feed;
    uint errorCount;

    function rate(address token) public returns (uint value, bool success) {
        // 如果错误超过10次,永久关闭这个机制
        require(errorCount < 10);
        try feed.getData(token) returns (uint v) {
            return (v, true);
        } catch Error(string memory /*reason*/) {
            // revert() 在getData中被调用，并且提供了一个reason字符串
            // revert("reasonString") 或者 require(false, "reasonstring")引起的则执行这个catch
            errorCount++;
            return (0, false);
        } catch Panic(uint /*errorCode*/) {
            // 使用 panic() 执行
            // 错误码可以使用确定的错误类型
            // 如 assert 失败，除以0，无效的数组访问，算术溢出等，将执行这个catch
            errorCount++;
            return (0, false);
        } catch (bytes memory /*lowLevelData*/) {
            // 使用 revert() 执行
            // 如果错误签名不符合任何其他子句，或者异常没有一起提供错误数据，子句的声明提供了低级错误数据访问
            errorCount++;
            return (0, false);
        }
    }
}
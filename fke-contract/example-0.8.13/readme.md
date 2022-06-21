<H1> Solidity 0.8.13 </H1>

<H2>目录</H2>

[TOC]


## 官方文档
+ [官方英文版](https://docs.soliditylang.org/en/v0.8.13/index.html){:target="_blank"}
+ [中文翻译版](https://learnblockchain.cn/docs/solidity/index.html){:target="_blank"}

## 项目结构

### 第一部分
#### Storege
#### Subcurrency

### 第二部分
#### Voting
#### SimpleAuction
#### BlindAuction
#### Purchase

### contract
#### 合约结构
+ 状态变量
    + 1
+ 函数
    + 函数通常在合约内部定义，但是也可以在外部定义。
    + 函数调用可以发生在合约内部或外部；且函数对其他合约由不同程度的可见性。
    + 函数可以接收参数和返回值
+ 函数修改器(modifier)
    + 函数和修改器可以被重写(overridden)
+ 事件(event)
    + 事件是能方便地调用以太坊虚拟机日志功能的接口。
+ 错误(error)
    + 允许用户自定义`error`来描述错误名称和数据
    + 错误在`revert`语句中使用
+ 结构体(struct)
    + 可以将几个变量组合在一起来定义一个新的类型
+ 枚举类型(enum)
    + 创建由一定数量的`常量值`构成的自定义类型

#### 类型

**<font color=red>`Solidity` 是静态类型语言,所以每个变量(状态变量和局部变量)都需要在编译时指定变量的类型</font>**

**<undefined\>或<null\>值的概念 `Solidity` 中不存在;申明的变量都会有一个默认值(和类型有关)**


+ 值类型
    + 布尔类型
    > `true` `false`

        > 运算符 `&&` `||` `!` `==` `!=`

    + 整形
    > `int` 和 `uint` ： 分别表示有符号和无符号的整形变量。 <font color="red">`uint8` 到 `uint256` 以及 `int8` 到 `int256` 以 `8` 位为步长增长; `uint` 和 `int` 分别是 `uint256` 和 `int256` 的别名</font>。

        + 比较运算符： `<=`, `<`, `==`, `!=`, `>=`, `>` （返回布尔值）
        + 位运算符： `&`, `|`, `^` (异或), `~` (位取反)
        + 位移运算符： `<<`(左位移), `>>` (右位移)
        + 算数运算符： `+`, `-`, 一元运算符`-`（仅针对有符号整形), `*`, `/`, `%` (取余或叫模运算), `**` (幂)

        > 整形`x`, 可以使用`type(x).min` 和 `type(x).max` 获取这个类型的最小和大值; `uint32` 取值范围 `0 ~ 2 ** 32-1`

        + 算数运算的2个计算模式： 截断模式(unchecked) 和检查模式(checked), 模式是checked模式

    + 定长浮点型
        > 暂未实际应用
    + 地址类型(address)
    > 所有成员，参考 [<font color="red">**地址成员**</font>](https://learnblockchain.cn/docs/solidity/units-and-global-variables.html#address-related){:target="_blank"}
        + `balance` `transfer` `send`

    + 合约类型
    > address 和 address payable
    
    + 定长字节数组
    + 变长字节数组
    + 地址字面常量
    + 有理数和整数字面常量
    + 字符串字面常量及类型
    + Unicode 常量
    + 十六进制常量
    + 枚举类型
    > `type(NameOfEnum).min` 以及 `type(NameOfEnum).max` 得到给定枚举的最小值和最大值。

    + 函数类型
    > `function (<parameter types>) {internal|external} [pure|constant|view|payable] [returns (<return types>)]`

        
        *public (或external)函数都有下面的成员*：

        + `.address` 返回函数的合约地址
        + `.selector` [<font color="blue">**返回ABI函数选择器**</font>](https://learnblockchain.cn/docs/solidity/abi-spec.html#abi-function-selector){:target="_blank"}

+ 引用类型
    + `memory` 数据在内存中,因此数据仅在生命周期内(函数调用期间)有效。不能用于外部调用
    + `storage` 状态变量保存的位置,只要合约存在就一直存储。
    + `calldata` 用来保存函数参数的特殊数据位置,是一个只读位置(类似memory)。

        + 数据位置
        > `memory`  `storage`  `calldata`

        + 数据位置和赋值行为
        > storage <=> memory (或者从calldata赋值)： 创建一份独立的拷贝

            > memory <=> memory : 只创建引用,意味着更改内存变量,其他引用相同数据的内存变量也随之改变

            > storage => 本地存储 ： 引用

            > 其他的 => storage ： 总是进行拷贝  

        + 数组
        > `uint[][5]` (声明一个长度为5，元素类型为uint的动态数组的数组)(二维数组); 与其他语言刚好相反(int[5][])。

            > 数组的下标从0开始,且访问数组时下标顺序与声明时相反： 例如访问二维数组第三个动态数组的第7个元素 `x[2][6]`

            > `public`标记的数组, Solidity 创建一个 <font color="blue">getter函数</font>

            > `.push()` 方法在数组末尾追加一个新元素

            > `bytes` 和 `string` 类型变量是特殊数组，但不允许使用长度或索引来访问； Solidity 可以使用第三方字符串库 `keccak256(abi.encodePacked(s1))` 比较字符串 和 `string.concat(s1, s2)`拼接字符串

        + 函数
        > `string.concat` 连接任意数量的`string`字符串，返回一个`string memory`; 同样`bytes.concat` 函数可以连接任意数量的`bytes` 或`bytes1 ... bytes32`,返回 `bytes memory`

        + 创建内存数组
        > `new` 在内存中基于运行时创建动态长度数组;与storage数组相反,不能通过`.push`来改变内存数组大小

        + 数组常量
        + 数组成员
        + 数组切片
        + 结构体

+ 映射
+ 操作符
+ 基本类型转换
+ 常量与基本类型转换





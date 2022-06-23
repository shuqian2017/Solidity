<H1> Solidity 0.8.13 </H1>

<H2>目录</H2>

[TOC]

&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;

## 1. 官方文档
+ [官方英文版](https://docs.soliditylang.org/en/v0.8.13/index.html){:target="_blank"}
+ [中文翻译版](https://learnblockchain.cn/docs/solidity/index.html){:target="_blank"}

## 2. 文档结构

### 2.1 基础

#### 2.1.1 智能合约入门
+ SimpleStorage
+ Coin

#### 2.1.2 根据例子学习Solidity
+ Ballot 
+ SimpleAuction
+ BlindAuction
+ Purchase
+ ReceiverPays
+ SimplePaymentChannel 
+ Token 

### 2.2 Solidity详解

#### 2.2.1 合约结构
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

#### 2.2.2 类型

**<font color=red>`Solidity` 是静态类型语言,所以每个变量(状态变量和局部变量)都需要在编译时指定变量的类型</font>**

**<undefined\>或<null\>值的概念 `Solidity` 中不存在;申明的变量都会有一个默认值(和类型有关)**


+ 值类型
    + 布尔类型
    > `true` `false`  
    <br/>
    > 运算符 `&&` `||` `!` `==` `!=`

    + 整形
    > `int` 和 `uint` ： 分别表示有符号和无符号的整形变量。 <font color="red">`uint8` 到 `uint256` 以及 `int8` 到 `int256` 以 `8` 位为步长增长; `uint` 和 `int` 分别是 `uint256` 和 `int256` 的别名</font>。

        + 比较运算符： `<=`, `<`, `==`, `!=`, `>=`, `>` （返回布尔值）
        + 位运算符： `&`, `|`, `^` (异或), `~` (位取反)
        + 位移运算符： `<<`(左位移), `>>` (右位移)
        + 算数运算符： `+`, `-`, 一元运算符`-`（仅针对有符号整形), `*`, `/`, `%` (取余或叫模运算), `**` (幂) 
        + 算数运算的2个计算模式： 截断模式(unchecked) 和检查模式(checked), 模式是checked模式  
        &nbsp;
        > 整形`x`, 可以使用`type(x).min` 和 `type(x).max` 获取这个类型的最小和大值; `uint32` 取值范围 `0 ~ 2 ** 32-1`

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
        > 它是一个静态大小的内存数组,其长度为表达式的数量; 数组的基本类型是列表第一个表达式的类型, 例如 `[1, 2, 3]` 类型为 `uint8[3] memory` 因为每个常量的类型都是`uint8`

            > 定长的memory数组不能赋值给变长的memory数组： uint[] x = [uint(1), 3, 4]

            > 初始化动态长度的数组，则必须要显示给各个元素赋值


        + 数组成员
        > 数组成员方法： `length`  `push()`  `push(x)`  `pop()`

            > `push()` 与 `push(x)` 区别： 都可以动态存储数组以及`bytes`类型（`string`类型不可以）不同则为`push()`添加元素后,并返回元素索引,`push(x)`函数没有返回值

            > `pop()` 存储变长的数组以及`bytes` 类型(string 类型不可以)，作用是从数组末尾删除元素

        + 数组切片
        > `x[start:end]` start 和 end 是uint256类型(或者结果为uint256的表达式); 数组切片没有类型名称，所以没有变量可以将数组切片作为类型，它们仅存在于中间表达式中 

        + 结构体

+ 映射
    + 映射声明 `mapping (KeyType => ValueType)` ;其中 `bytes`和`string`之外的数组类型不可作为KeyType, ValueType没有限制
    + 映射只能是`storage`的数据位置; (包含)映射不能作为函数的参数或返回值
    + 可迭代映射： 映射本身无法迭代的,但是可以在它们之上实现一个数据结构来进行迭代

+ 操作符
    + 计算 `y = x + z` 其中 x 是 uint8, z 是int32;  前提左边或右边 可以进行隐式转换
    + 三元运算符： `<expression> ? <trueExpression> : <falseExpression>` 由 `<expression>` 的执行结果选择后面2个给定表达式中的一个
    + delete 
    > `delete a` 对于动态数组是重置数组长度为0；对于静态数组是将所有元素重置为初始值； delete a[x] 仅删除数组索引`x`处的元素

        > `delete a` 对于结构体，则是将结构体中的所有属性(成员)重置

        > `delete a` 对于映射是无效的; (因此在删除结构体时，结果是将重置所有非映射属性(成员)) 

+ 基本类型转换
    + 隐式转换
    ```solidity
    // 整个过程: y -> uint16, 执行相加操作后得到uint16 -> uint32类型的x 
    uint8 y;
    uint16 z;
    uint32 x = y + z;
    ```
    + 显示转换
    ```solidity
    // example1
    int8 y = -3;
    uint x = uint(y);  // x 的值将是 0xfffff..fd （64 个 16 进制字符)

    // example2
    uint32 a = 0x12345678;
    uint16 b = uint16(a); // 此时 b 的值是 0x5678 （高位被舍弃）

    // example3
    uint16 a = 0x1234;
    uint32 b = uint32(a); // b 为 0x00001234 now
    assert(a == b);

    // example4
    bytes2 a = 0x1234;
    bytes1 b = bytes1(a); // b 为 0x12   （转换为较小类型将切断序列）

    // example5
    bytes2 a = 0x1234;
    bytes4 b = bytes4(a); // b 为 0x12340000  (定长字节数组转换为更大类型,按正确方式填充)
    assert(a[0] == b[0]);
    assert(a[1] == b[1]);
    ```

        ```solidity
        // example6
        bytes2 a = 0x1234; 
        uint32 b = uint16(a); // b 为 0x00001234 
        uint32 c = uint32(bytes4(a)); // c 为 0x12340000 
        uint8 d = uint8(uint16(a)); // d 为 0x34 
        uint8 e = uint8(bytes1(a)); // e 为 0x12
        ```

+ 常量与基本类型转换
    + 整形与字面常量转换
    ```solidity
    uint8 a = 12; //  可行
    uint32 b = 1234; // 可行
    uint16 c = 0x123456; // 失败, 会截断为 0x3456
    ```

    + 定长字节数组与字面常量转换
    ```solidity
    bytes2 a = 54321; // 不可行
    bytes2 b = 0x12; // 不可行
    bytes2 c = 0x123; // 不可行
    bytes2 d = 0x1234; // 可行
    bytes2 e = 0x0012; // 可行
    bytes4 f = 0; // 可行
    bytes4 g = 0x0; // 可行   
    ```

        ```solidity
        bytes2 a = hex”1234”; // 可行 
        bytes2 b = “xy”; // 可行 
        bytes2 c = hex”12”; // 不可行 
        bytes2 d = hex”123”; // 不可行 
        bytes2 e = “x”; // 不可行 
        bytes2 f = “xyz”; // 不可行
        ```

    + 地址类型
    > 从`bytes20` 或其他整形显示转换为`address` 类型时, 都会作为`address payable` 类型

        > 一个地址`address a` 可以通过 payable(a) 转换为 `address payable` 类型

#### 2.2.3 单位和全局变量

+ 以太币单位(缺省为 wei)
    ```solidity
    assert(1 wei == 1);
    assert(1 gwei == 1e9);
    assert(1 ether == 1e18);
    ```

+ 时间单位(缺省为 秒)
    > `seconds`、 `minutes`、 `hours`、 `days` 和 `weeks` 的可以进行换算

    ```solidity
    1 == 1 seconds
    1 minutes == 60 seconds
    1 hours == 60 minutes
    1 days == 24 hours
    1 weeks == 7 days
    ```

    > **代码中进行单位换算示例**

    ```solidity
    function f(uint start, uint daysAfter) public {
        if (block.timestamp >= start + daysAfter * 1 days) {
            // ...
        }
    }
    ```

+ 特殊变量和函数
    + 区块和交易属性
    ```text
    blockhash(uint blockNumber) returns (bytes32)：指定区块的区块哈希 —— 仅可用于最新的 256 个区块且不包括当前区块，否则返回 0 。
    block.basefee (uint): 当前区块的基础费用，参考： (EIP-3198 和 EIP-1559)
    block.chainid (uint): 当前链 id
    block.coinbase ( address ): 挖出当前区块的矿工地址
    block.difficulty ( uint ): 当前区块难度
    block.gaslimit ( uint ): 当前区块 gas 限额
    block.number ( uint ): 当前区块号
    block.timestamp ( uint): 自 unix epoch 起始当前区块以秒计的时间戳
    gasleft() returns (uint256) ：剩余的 gas
    msg.data ( bytes ): 完整的 calldata
    msg.sender ( address ): 消息发送者（当前调用）
    msg.sig ( bytes4 ): calldata 的前 4 字节（也就是函数标识符）
    msg.value ( uint ): 随消息发送的 wei 的数量
    tx.gasprice (uint): 交易的 gas 价格
    tx.origin ( address ): 交易发起者（完全的调用链）    
    ```

    + ABI编码和解码函数
    > abi.decode(bytes memory encodedData, (...)) returns (...): 对给定的数据进行ABI解码，而数据的类型在括号中第二个参数给出 。 例如: <font color="red"> (uint a, uint[2] memory b, bytes memory c) = abi.decode(data, (uint, uint[2], bytes)) </font>

        > abi.encode(...) returns (bytes)： ABI - 对给定参数进行编码

        > abi.encodePacked(...) returns (bytes)：对给定参数执行 紧打包编码 ，注意，可以不明确打包编码。

        >abi.encodeWithSelector(bytes4 selector, ...) returns (bytes)： ABI - 对给定第二个开始的参数进行编码，并以给定的函数选择器作为起始的 4 字节数据一起返回

        > abi.encodeWithSignature(string signature, ...) returns (bytes)：等价于 abi.encodeWithSelector(bytes4(keccak256(signature), ...)

        > abi.encodeCall(function functionPointer, (...)) returns (bytes memory): 使用tuple类型参数ABI 编码调用 functionPointer 。执行完整的类型检查, 确保类型匹配函数签名。结果和 abi.encodeWithSelector(functionPointer.selector, (...)) 一致。

        > `keccak256(abi.encodePacked(a, b))` 是一种计算结构化数据的哈希值

    + 错误处理 [专门章节](https://learnblockchain.cn/docs/solidity/control-structures.html#assert-and-require){:target="_blank"}     
        + `assert`  `require`  `revert`

    + 数学和密码学函数 [使用案例](https://ethereum.stackexchange.com/questions/1777/workflow-on-signing-a-string-with-private-key-followed-by-signature-verificatio){:target="_blank"}
        + `addmod(uint x, uint y, uint k) returns (uint)`  :  (x + y) % k
        + `mulmod(uint x, uint y, uint k) returns (uint)`  :  (x * y) % k
        + `keccak256((bytes memory) returns (bytes32)` :  计算 Keccak-256 哈希
        + `sha256(bytes memory) returns (bytes32)`  : 计算参数的 SHA-256 哈希
        + `ripemd160(bytes memory) returns (bytes20)` : 计算参数的 RIPEMD-160 哈希
        + `ecrecover(bytes32 hash, uint8 v, bytes32 r, bytes32 s) returns (address)` : 利用椭圆曲线签名恢复与公钥相关的地址，错误返回零值

    + 地址成员 [地址类型Address](https://learnblockchain.cn/docs/solidity/types.html#address){:traget="_blank"}

    + 合约相关
        + `this` 当前合约
        + `selfdestruct(address payable recipient)` : 销毁合约，并把余额发送到指定地址

    + 类型信息
        + type(C).name ： C用于合约类型; 获取合约名
        + type(C).creationCode : C用于合约类型; 获得包含创建合约字节码的内存字节数组
        + type(C).runtimeCode ： C用于合约类型; 获得合约的运行时字节码的内存字节数组
        + type(I).interfaceId ： 返回接口``I`` 的 bytes4 类型的接口 ID
        + type(T).min ： T用于整形; T的最小值
        + type(T).max  : T用于整形; T的最大值



#### 2.2.4 表达式和控制结构


#### 2.2.5 合约






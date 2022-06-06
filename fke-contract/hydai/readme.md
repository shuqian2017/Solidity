
## contract实战

### day3 
合约地址： `0xd48919FA73384ec25278fB565b16782724423307`

+ public , external,  internal, private
+ pure（纯净的）,   view  

### day4
Ganache & Remix  (本地测试节点)

### day5 
合约地址： `0x31e26af298bc27464163c329C9982c6059D4dd42`

+ State Variables
+ constructor  （构造函数）
+ revert

### day6
合约地址： `0xde9E3ec50c8fA6fDf6DaA6ed1355cC229187429d`

modifier  （`_;`表示执行完这个modifer之后，会去往下执行原本function的事情 ）

+ Function modifier

### day7
合约地址： `0xEfFAb006a4714dEAA11b09E405e8b008fAC9B273`

require , revert , assert 区别

### day8
合约地址： `0x2d06c13206e8De495Aa93c8A48e6336c02B50a05`

+ event  , log  , emit
+ topics 在每个log中只能有4个； Keccak-256 

### day9
合约地址： `0xa5fe6f2d82748255dd5849d868358a7575b9c4f4`

fallback  (每个contract仅有一个) , payable(收钱)

**fallback中尽量不要做以下4件事情**

+ Modify storage
+ Create a contract
+ Call an external function
+ Send ethers

### day10
+ address type     (1 Ether =  10^3 Finney = 10^18 Wei  )
+ send  & transfer 方法

### day11
mapping (T1 => T2)   ； mapping无法迭代，可以自己写helper function实现

### day12
struct 

### day13 ~ day14
捐款示例

### day15
+ Abstract contract  （抽象合约）
+ contract A is B {}   (A继承B)
+ `Internal`关键字能使 Abstract Contract 具备一个构建函数；constructor 被声明为internal时，该contract会被当作`Abstract Contract`

### day16
interface  只能定义function 且其modifier应该为`external`； 不能继承、constructor、变量、struct、enum

### day17
+ library 部署一次且在指定位置，但是可以被多个地方使用；没有`state variables`; 不能继承; 无法接收Ether；

+ 通过library把mapping包装成常见的set结构 
> + Set.Insert(Key)   // 插入
> + Set.Remove(Key)   // 移除
> + Set.Contain(Key)  // 包含

### day18
SafeMath  （常见的公共库: add、 sub、 mul、 div、 mod）

[SafeMath](https://github.com/OpenZeppelin/openzeppelin-contracts/tree/master/contracts/utils/math){:target="_blank"}

### day19
Import 、 using ... for 

### day20
ERC20 Interface

### day21
ERC20 -1 

### day21
ERC20 -2 

### day22
ERC20 -3

### day23
 ERC20 Optional

### day24
ERC20 Mint

### day25
ERC20 Burn

### day26
ERC20 Pausable

### day27
Investments Example

### day28
ERC20 Token Exchange

### day29
ICO

### day30
总结 



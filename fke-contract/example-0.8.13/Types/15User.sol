// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.8;

/*
* 第三部分： 映射
* 实现可迭代映射的例子
*/

struct IndexValue {
    uint keyIndex;
    uint value;
}

struct KeyFlag {
    uint key;
    bool deleted;
}

struct itmap {
    mapping (uint => IndexValue) data;
    KeyFlag[] keys;
    uint size;
}

type Iterator is uint;

library IterableMapping {
    function insert(itmap storage self, uint key, uint value) internal returns (bool replaced) {
        uint keyIndex = self.data[key].keyIndex;
        self.data[key].value = value;
        if (keyIndex > 0)   // 如果大于0，相当于已经insert过，所以直接跳过
            return true;
        else {
            keyIndex = self.keys.length;

            self.keys.push();
            self.data[key].keyIndex = keyIndex + 1;
            self.keys[keyIndex].key = key;
            self.size++;
            return false;
        }
    }

    function remove(itmap storage self, uint key) internal returns (bool success) {
        uint keyIndex = self.data[key].keyIndex;
        if (keyIndex == 0)
            return false;
        delete self.data[key];
        self.keys[keyIndex - 1].deleted = true;
        self.size--;
    }

    function contains(itmap storage self, uint key) internal view returns (bool) {
        return self.data[key].keyIndex > 0;
    }

    function iterateStart(itmap storage self) internal view returns (Iterator) {
        return iteratorSkipDeleted(self, 0);
    }

    function iterateValid(itmap storage self, Iterator iterator) internal view returns (bool) {
        return Iterator.unwrap(iterator) < self.keys.length;
    }

    function iterateNext(itmap storage self, Iterator iterator) internal view returns (Iterator) {
        return iteratorSkipDeleted(self, Iterator.unwrap(iterator) + 1);
    }

    function iterateGet(itmap storage self, Iterator iterator) internal view returns (uint key, uint value) {
        uint keyIndex = Iterator.unwrap(iterator);
        key = self.keys[keyIndex].key;
        value = self.data[key].value;
    }

    function iteratorSkipDeleted(itmap storage self, uint keyIndex) private view returns (Iterator) {
        while (keyIndex < self.keys.length && self.keys[keyIndex].deleted)
            keyIndex++;
        return Iterator.wrap(keyIndex);
    }
}


/// 如何使用
contract User {
    // 只有一个持有我们数据的结构体
    itmap data;
    // 将库函数应用于数据类型
    using IterableMapping for itmap;

    // 插入收据
    function insert(uint k, uint v) public returns (uint size) {
        // 调用 IterableMapping.insert(data, k, v)
        data.insert(k, v);
        // 我们依然可以访问结构体的成员
        // 但是我们需要注意不要与他们混乱
        return data.size;
    }

    function remove(uint k) public returns (uint size) {
        data.remove(k);
        return data.size;
    }

    // 计算所有存储数据的总和
    function sum() public view returns (uint s) {
        for (
            Iterator i = data.iterateStart();
            data.iterateValid(i);
            i = data.iterateNext(i)
        ) {
            (, uint value) = data.iterateGet(i);
            s += value;
        }
    }
}
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.9.0;

/*
* 第三部分： 引用类型
* 结构体的例子
*/


// 定义的新类型包含两个属性。
// 在合约外部声明结构体可以使其被多个合约共享。在这里，这并不是很正需要的
struct Funder {
    address addr;
    uint amount;
}

contract CrowdFunding {

    // 也可以在合约内部定义结构体, 这使得它们仅在此合约和衍生合约中可见。
    struct Campaign {
        address payable beneficiary;
        uint fundingGoal;
        uint numFunders;
        uint amount;
        mapping (uint => Funder) funders;
    }

    uint numCampaigns;
    mapping (uint => Campaign) campaigns;

    function newCampaign(address payable beneficiary, uint goal) public returns (uint campaignID) {
        campaignID = numCampaigns++;        // campaignID 作为一个变量返回
        // 不能使用 "campaigns[campaignID] = Campaign(beneficiary, goal, 0, 0)"
        // 0.7.0之前这样赋值可以,它会直接忽略映射类型。
        // 因为RHS (right hand side) 会创建一个包含映射的内存结构体"Campaign"
        Campaign storage c = campaigns[campaignID];
        c.beneficiary = beneficiary;
        c.fundingGoal = goal;
    }

    function contribute(uint campaignID) public payable {
        Campaign storage c = campaigns[campaignID];
        // 以给定的值初始化，创建一个新的临时memory 结构体,
        // 并将其拷贝到 storage 中。
        // 注意你也可以使用 Funder(msg.sender, msg.value) 来初始化
        c.funders[c.numFunders++] = Funder({addr: msg.sender, amount: msg.value});  // 统计每一笔捐赠
        c.amount += msg.value;
    }

    function checkGoalReached(uint campaignID) public returns (bool reached) {
        Campaign storage c = campaigns[campaignID];
        if (c.amount < c.fundingGoal)  // 此处判断未生效
            return false;
        uint amount = c.amount;
        c.amount = 0;
        c.beneficiary.transfer(amount);
        return true;
    }

    function getCampaignFunder(uint campaignID, uint funder) public view returns (Funder memory data) {
        return campaigns[campaignID].funders[funder];
    }
}
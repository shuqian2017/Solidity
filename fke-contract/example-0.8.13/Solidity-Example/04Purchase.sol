// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract Purchase {

    uint public value;
    address payable public seller;
    address payable public buyer;

    enum State {Created, Locked, Release, Inactive }
    State public state;

    modifier condition(bool condition_) {
        require(condition_);
        _;
    }

    /// Only the buyer can call this function.
    error OnlyBuyer();
    /// Only the seller can call this function.
    error OnlySeller();
    /// the function cannot be called at the current state.
    error InvalidState();
    /// the provided value has to be even.
    error ValueNotEven();

    modifier onlyBuyer() {
        require(msg.sender == buyer, "Only buyer can call this.");
        _;
    }

    modifier onlySeller() {
        require(msg.sender == seller, "Only seller can call this.");
        _;
    }

    modifier inState(State _state) {
        require(state == _state, "Invalid state.");
        _;
    }

    event Aborted();
    event PurchaseConfirmed();
    event ItemReceived();
    event SellerRefunded();

    // 确保 `msg.value` 是一个偶数
    // 如果它是一个奇数，则它将被截断。
    // 通过乘法检查它不是奇数。
    constructor() payable {
        seller = payable(msg.sender);
        value = msg.value / 2;
        if ((2 * value) != msg.value)
            revert ValueNotEven();
    }

    /// 中止购买并回收以太币
    /// 只能在合约被锁定之前由卖家调用。
    function abort() external onlySeller inState(State.Created) {
        emit Aborted();
        state = State.Inactive;
        seller.transfer(address(this).balance);
    }

    /// 买家确认购买
    /// 交易必须包含 `2 * value` 个以太币。
    /// 以太币会被锁定, 直到confirmReceived被调用。
    function confirmPurchase() external inState(State.Created)
        condition(msg.value == (2 * value)) payable {
            emit PurchaseConfirmed();
            buyer = payable(msg.sender);
            state = State.Locked;
    }

    /// 确认你(买家)已经收到商品。
    /// 这会释放被锁定的以太币。
    function confirmReceived() external onlyBuyer inState(State.Locked) {
        emit ItemReceived();
        // 因为首先改变状态很重要
        // 否则，合约使用`send`方法回调之后
        // 这里可以再次被调用
        state = State.Release;
        buyer.transfer(value);
    }

    /// 此功能退还给卖家,例如
    /// 支付卖家锁定的资金
    function refundSeller() external onlySeller inState(State.Release) {
        emit SellerRefunded();
        // 因为首先改变状态很重要
        // 否则，合约使用`send`方法回调之后
        // 这里可以再次被调用
        state = State.Inactive;
        seller.transfer(3 * value);
    }
}

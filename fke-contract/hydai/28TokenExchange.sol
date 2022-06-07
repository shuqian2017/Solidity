pragma solidity ^0.4.25;

import "./library/IERC20.sol";

contract TokenExchange {

    // From => UserA, TokenA
    address fromAddress;
    address fromToken;
    uint256 fromAmount;
    // To => UserB, TokenB
    address toToken;
    uint256 toAmount;

    // 假设 UserA 已经Approve
    function CreateExchange(address _fromToken, uint256 _fromAmount, 
        address _toToken, uint256 _toAmount) public {
            // 检查 _fromToken 进行 transferFrom 可以成功.
            require(IERC20(_fromToken).transferFrom(msg.sender, this, _fromAmount));
            fromAddress = msg.sender;
            fromToken = _fromToken;
            fromAmount = _fromAmount;
            toToken = _toToken;
            toAmount = _toAmount;
    }

    function DoExchange() public {
        // 检查 toToken 进行 transferFrom 可以成功.
        require(IERC20(toToken).transferFrom(msg.sender, this, toAmount));
        IERC20(fromToken).transfer(msg.sender, fromAmount);
        IERC20(toToken).transfer(fromAddress, toAmount);
    }
}
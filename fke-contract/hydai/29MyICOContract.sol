pragma solidity ^0.4.25;

import "./library/SafeMath.sol";
import "./library/ICOToken.sol";

contract MyICOContract {
    using SafeMath for uint;

    address private owner = 0x0;
    address public tokenAddress = 0x0;
    uint256 caps = 0;
    uint256 currentFund = 0;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    enum ICOState {PREPARE, START, END}
    ICOState public icoState = ICOState.PREPARE;

    modifier beforeICO() {
        require(icoState == ICOState.PREPARE);
        _;
    }

    modifier whenICOStart() {
        require(icoState == ICOState.START);
        _;
    }

    modifier whenICOEnd() {
        require(icoState == ICOState.END);
        _;
    }

    constructor() public {
        owner = msg.sender;
        string memory name = "FKE Token";
        uint8 decimals = 18;
        string memory symbol = "FKE";
        uint256 totalSupply = 1000 * (10 ** 18);
        caps = totalSupply;
        tokenAddress = new ICOToken(name, decimals, symbol, totalSupply);
    }

    function startICO() public onlyOwner beforeICO {
        icoState = ICOState.START;
    }

    function endICO() public onlyOwner whenICOStart {
        icoState = ICOState.END;
        owner.transfer(address(this).balance);
        IERC20(tokenAddress).transfer(owner, caps.sub(currentFund));
    }

    function() public payable whenICOStart {
        require(msg.value > 0);
        // 1 Ether -> 5 Tokens
        require(caps.sub(currentFund) >= msg.value.mul(5), "Parameter error");
        currentFund = currentFund.add(msg.value.mul(5));
        IERC20(tokenAddress).transfer(msg.sender, msg.value.mul(5));
    }
}
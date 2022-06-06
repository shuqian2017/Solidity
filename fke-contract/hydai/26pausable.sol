pragma solidity ^0.4.25;

import "./library/SafeMath.sol";

contract Pausable {
    using SafeMath for uint256;

    bool private _paused;
    address private _owner;
    mapping(address => uint256) _balances;

    constructor() public {
        _paused = false;
        _owner = msg.sender;
    }

    modifier whenPaused() {
        require(_paused);
        _;
    }

    modifier whenNotPaused() {
        require(!_paused);
        _;
    }

    modifier onlyOwner() {
        require(_owner == msg.sender, "Perssion defined.");
        _;
    }

    event Pause(address addr);
    event Unpause(address addr);
    event Transfer(address from, address to, uint256 tokens);

    function pause() public whenNotPaused onlyOwner returns (bool) {
        _paused = true;
        emit Pause(msg.sender);
        return true;
    }

    function unpause() public whenPaused onlyOwner returns (bool) {
        _paused = false;
        emit Unpause(msg.sender);
        return true;
    }

    function transfer(address from, address to, uint256 tokens) 
        whenNotPaused public  payable returns (bool) {
            require(from != address(0) && to != address(0), "address not allow 0.");
            _balances[from] = _balances[from].sub(tokens);
            _balances[to] = _balances[to].add(tokens);
            emit Transfer(from, to, tokens);
            return true;
    }
}
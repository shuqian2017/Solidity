pragma solidity ^0.4.25;

contract FallbackExample {
    event LogFallback(string message);
    event LogBalance(uint balance);

    function() public payable {
        emit LogFallback("Fallback");
        emit LogBalance(address(this).balance);
    }
}

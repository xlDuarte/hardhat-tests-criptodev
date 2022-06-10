pragma solidity >=0.7.0;

import "./gama-token.sol";

// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Airdrop {
    // Using Libs

    // Structs

    // Enum
    enum Status {
        ACTIVE,
        PAUSED,
        CANCELLED
    } // mesmo que uint8

    // Properties
    address private owner;
    address public tokenAddress;
    address[] private subscribers;
    Status contractState;

    // Modifiers
    modifier isOwner() {
        require(msg.sender == owner, "The sender is not the owner!");
        _;
    }

    // Events
    event NewSubscriber(address beneficiary, uint256 amount);

    // Constructor
    constructor(address token) {
        owner = msg.sender;
        tokenAddress = token;
        contractState = Status.ACTIVE;
    }

    // Public Functions
    //Subscribe
    function subscribe() public returns (bool) {
        assert(hasSubscribed(msg.sender) != true);
        subscribers.push(msg.sender);
        return true;
    }

    //Execute
    function execute() public isOwner returns (bool) {
        uint256 balance = CryptoToken(tokenAddress).balanceOf(address(this));
        uint256 amountToTransfer = balance / subscribers.length;
        for (uint256 i = 0; i < subscribers.length; i++) {
            require(subscribers[i] != address(0));
            require(
                CryptoToken(tokenAddress).transfer(
                    subscribers[i],
                    amountToTransfer
                )
            );
        }
        return true;
    }

    //State
    function state() public view returns (Status) {
        return contractState;
    }

    // Private Functions
    function hasSubscribed(address subscriber) private returns (bool) {
        for (uint256 s = 0; s < subscribers.length; s++) {
            require(subscriber != subscribers[s], "Address already exists!");
        }
        return false;
    }

    // Kill
    function Kill(address wallet) public isOwner {
        selfdestruct(payable(wallet));
    }
}

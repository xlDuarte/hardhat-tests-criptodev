//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Greeter {
    string private greeting;

    constructor(string memory _greeting) {
        console.log(
            "Dando boas vindas com o Greeter com a mensagem: \n",
            _greeting
        );
        greeting = _greeting;
    }

    function greet() public view returns (string memory) {
        return greeting;
    }

    function setGreeting(string memory _greeting) public {
        console.log(
            "\nMudando as boas vindas de '%s' para '%s'.",
            greeting,
            _greeting
        );
        greeting = _greeting;
    }
}
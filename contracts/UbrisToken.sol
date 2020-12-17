// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {

    constructor() public ERC20("Ubris", "UBS2") {
        _mint(msg.sender, 1000000000000000000000000);
        _mint(address(this), 1000000000000000000000000);
    }

    function faucet() public {
        require(balanceOf(msg.sender) < 5, "You have to much tokens to use this faucet");
        this.transfer(msg.sender, 1);
    }

}

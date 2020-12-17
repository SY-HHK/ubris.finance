// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract UbrisToken is ERC20 {

    constructor(uint256 initialSupply) public ERC20("UbrisToken", "UBS") {
        _mint(msg.sender, initialSupply/2);
        _mint(address(this), initialSupply/2);
    }

    //free faucet
    function faucet() public {
        require(balanceOf(msg.sender) < 10, "You have to much tokens to use this faucet");
        this.transfer(msg.sender, 1);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/UbrisToken.sol";

contract TestUbrisToken {

    UbrisToken token;
    uint initial_supply = 1000;

    function beforeAll() public {
        token = new UbrisToken(initial_supply);
    }

    function testContractBalance() public {
        Assert.equal(token.balanceOf(address(this)), initial_supply/2, "should be equal");
    }
}

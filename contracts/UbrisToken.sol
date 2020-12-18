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

     //////////////////////////////////
    //             POOL             //
   //////////////////////////////////

    struct StackedIn {
        uint date;
        uint amount;
    }

    struct Stacker {
        StackedIn[] stack;
        uint lastHarvestDate;
    }

    mapping (address => Stacker) stackedAmount;

    //add stack in pool
    function stackIn(uint _amount) public {
        require(_amount > 0);
        require(balanceOf(msg.sender) >= _amount);
        if (transferFrom(msg.sender, address(this), _amount)) {
            StackedIn memory newStack = StackedIn(block.timestamp, _amount);
            stackedAmount[msg.sender].stack.push(newStack);
        }
    }

    //retire stack from pool
    function stackOut() public {
        Stacker memory stacker = stackedAmount[msg.sender];
        for (uint i = 0; i < stacker.stack.length; i+=1) {
            this.transfer(msg.sender, stacker.stack[i].amount);
        }
        delete stackedAmount[msg.sender].stack;
    }

    //calcul harvest
    function getHarvestable() view public returns(uint) {
        uint harvestable = 0;
        Stacker memory stacker = stackedAmount[msg.sender];
        for (uint i = 0; i < stacker.stack.length; i+=1) {
            if (stacker.lastHarvestDate > stacker.stack[i].date) {
                harvestable += (stacker.stack[i].amount / 100) * ((block.timestamp - stacker.lastHarvestDate) / 10 seconds);
            }
            else {
                harvestable += (stacker.stack[i].amount / 100) * ((block.timestamp - stacker.stack[i].date) / 10 seconds);
            }
        }
        return harvestable;
    }

    //harvest
    function harvest() public {
        this.transfer(msg.sender, getHarvestable());
        stackedAmount[msg.sender].lastHarvestDate = block.timestamp;
    }
}

pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
//import "@openzeppelin/contracts/access/Ownable.sol"; //https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract YourContract {

    address payable depositor;
    uint deposited;

    mapping(address => uint256) balance;

    function deposit() payable public {
        require(msg.value > 0);
        depositor = payable(msg.sender);
        deposited = msg.value;
        balance[depositor] = deposited;
        console.log("%s deposited %s in the vault", depositor, deposited);
    }

    function checkBalance() public view returns (uint) {
        return address(this).balance;
    }

    function withdraw(uint withdrawRequest) public {
        require(withdrawRequest > 0, "should be greater than 0");
        require(withdrawRequest <= deposited, "should be less than or equal to balance");
        require(msg.sender == depositor, "hey not your money!");

        depositor.transfer(withdrawRequest);
    }
}

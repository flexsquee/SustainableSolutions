// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SustainableDonations {
    address public owner;
    mapping(address => uint) public donations;

    event DonationReceived(address indexed donor, uint amount);
    event Withdrawn(uint amount, address indexed recipient);

    constructor() {
        owner = msg.sender; // Set contract deployer as the owner
    }

    // Function to receive donations
    function donate() public payable {
        require(msg.value > 0, "Donation amount must be greater than zero.");
        donations[msg.sender] += msg.value;
        emit DonationReceived(msg.sender, msg.value);
    }

    // Function for owner to withdraw funds
    function withdraw(uint amount) public onlyOwner {
        require(amount <= address(this).balance, "Insufficient funds.");
        payable(owner).transfer(amount);
        emit Withdrawn(amount, owner);
    }

    // Modifier to restrict access to owner
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner.");
        _;
    }

    // Check contract balance
    function contractBalance() public view returns (uint) {
        return address(this).balance;
    }
}

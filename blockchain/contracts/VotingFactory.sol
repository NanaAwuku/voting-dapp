// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./Voting.sol"; // Import the Voting contract

contract VotingFactory {
    address[] public deployedVotingContracts;

    // Create a new Voting contract instance
    function createVoting() public {
        address newVotingContract = address(new Voting());
        deployedVotingContracts.push(newVotingContract);
    }

    // Get the list of deployed Voting contracts
    function getDeployedVotingContracts() public view returns (address[] memory) {
        return deployedVotingContracts;
    }

    // Check if an address corresponds to a deployed Voting contract
    function isVotingContract(address contractAddress) public view returns (bool) {
        for (uint i = 0; i < deployedVotingContracts.length; i++) {
            if (deployedVotingContracts[i] == contractAddress) {
                return true;
            }
        }
        return false;
    }

    // Get the number of deployed Voting contracts
    function getNumberOfDeployedContracts() public view returns (uint) {
        return deployedVotingContracts.length;
    }

    // Remove a deployed Voting contract from the list (admin-only)
    function removeVotingContract(address contractAddress) public {
        require(isVotingContract(contractAddress), "Not a deployed Voting contract");
        require(msg.sender == owner, "Only the owner can remove contracts");
        
        for (uint i = 0; i < deployedVotingContracts.length; i++) {
            if (deployedVotingContracts[i] == contractAddress) {
                deployedVotingContracts[i] = deployedVotingContracts[deployedVotingContracts.length - 1];
                deployedVotingContracts.pop();
                break;
            }
        }
    }
    
    // Transfer ownership of the factory (admin-only)
    function transferOwnership(address newOwner) public {
        require(msg.sender == owner, "Only the owner can transfer ownership");
        owner = newOwner;
    }
    
    // Check if the caller is the current owner of the factory
    function isOwner() public view returns (bool) {
        return msg.sender == owner;
    }

    address public owner;

    constructor() {
        owner = msg.sender;
    }
}

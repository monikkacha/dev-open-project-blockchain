//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract DevOpenProject {
    enum Role {
        Developer,
        Accountant,
        DevOps
    }

    struct Project {
        int256 id;
        address proposedBy;
        string gitHub;
        string document;
        string[] website;
        string investement;
        Developer[] developers;
    }

    struct Member {
        int256 id;
        address payable account;
        bool isVotingEnable;
    }

    struct Developer {
        int256 id;
        address payable account;
        string firstName;
        string lastName;
        string githubProfile;
        string twitterProfile;
        string discordUserId;
        uint256 percantage;
        uint256 compensationRate;
        uint256 compensationTime;
        uint256 joinedTime;
        bool holdCredential;
        uint256 projectId;
        Role developerRole;
    }

    int256[] public balances;

    Project[] public projects;

    Project[] public projectProposal;
}

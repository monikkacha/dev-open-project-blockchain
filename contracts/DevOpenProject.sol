//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract DevOpenProject {
    struct Member {
        ;
    }

    struct Developer {
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
    }
}

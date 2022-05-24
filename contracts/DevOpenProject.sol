//SPDX-License-Identifier: Unlicense
pragma solidity >=0.5.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/drafts/Counters.sol";

import "hardhat/console.sol";

contract DevOpenProject {
    using Counters for Counters.Counter;
    enum Role {
        Developer,
        Accountant,
        DevOps
    }

    struct Vote {
        address voter;
        bool isUpvote;
    }

    struct Proposal {
        uint256 id;
        address proposedBy;
        string document;
        string github;
        uint256 createdAt;
        Vote[] voting;
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
        uint256 id;
        address payable account;
        bool isVotingEnable;
    }

    struct Developer {
        int256 id;
        address payable account;
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

    Member[] public members;

    Developer[] public developers;

    ERC20 devProToken;

    Counters.Counter public memberCount;
    Counters.Counter public projectCount;

    uint256 minimumTokenForBeingMember = 10;
    uint256 minimumTokenForProposeAProject = 2;

    modifier enoughToken(uint256 minimumAmount, string memory message) {
        uint256 balance = devProToken.balanceOf(msg.sender);
        require(balance >= (minimumAmount * (10**18)), message);
        _;
    }

    constructor(address tokenContractAddress) public {
        devProToken = ERC20(tokenContractAddress);
    }

    function claimMembership()
        public
        enoughToken(
            minimumTokenForBeingMember,
            "Not enough token to claim membership"
        )
    {
        memberCount.increment();
        Member memory member = Member(memberCount.current(), msg.sender, true);
        members.push(member);
    }

    function addProposal(
        string memory githubProfile,
        string memory twitterProfile,
        string memory discordUserId
    )
        public
        enoughToken(
            minimumTokenForProposeAProject,
            "Not enough token to propose project"
        )
    {}
}

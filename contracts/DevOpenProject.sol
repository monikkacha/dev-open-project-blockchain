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
        uint256 proposalNumber;
    }

    struct Proposal {
        address proposedBy;
        string document;
        string github;
        uint256 createdAt;
        uint256 endTime;
        bool isProposalVotingEnd;
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

    Proposal[] public projectProposal;

    Member[] public members;

    Developer[] public developers;

    Vote[] public votes;

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

    modifier hasVoted(address sender, uint256 proposalNumber) {
        // @dev
        // TODO :: draw back : loop through entire vote
        // find better one
        bool isFound = false;
        for (uint256 i = 0; i < votes.length; i++) {
            if (
                votes[i].voter == sender &&
                votes[i].proposalNumber == proposalNumber
            ) {
                isFound = true;
            }
        }
        require(
            isFound == false,
            "Already voted on proposal , multiple votes are not allowed"
        );
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

    function addProposal(string memory document, string memory github)
        public
        enoughToken(
            minimumTokenForProposeAProject,
            "Not enough token to propose project"
        )
    {
        Proposal memory proposal;
        proposal.createdAt = now;
        proposal.github = github;
        proposal.document = document;
        proposal.endTime = now + 3 days;
        proposal.isProposalVotingEnd = false;

        projectProposal.push(proposal);
    }

    function vote(bool isUpvote, uint256 proposalNumber)
        public
        hasVoted(msg.sender, proposalNumber)
    {
        Vote memory vote = Vote(msg.sender, isUpvote, proposalNumber);
        votes.push(vote);
    }
}

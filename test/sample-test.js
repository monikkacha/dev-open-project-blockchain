const { expect } = require("chai");
const { ethers } = require("hardhat");


describe("Deployment", async () => {

  const name = "DevProToken"
  const symobol = "DEV"
  const decimals = 18
  const totalSupply = ethers.utils.parseUnits("1000000", 18);
  const rate = 100;
  const wallet = '0x231464eF37dFBD7b3B9e55DaBAF79386910d82B3';
  let devProToken;
  let devCrowdsale;
  let owner;
  let addr1;
  let addr2;
  let addrs;

  beforeEach(async () => {
    const DevProToken = await ethers.getContractFactory("DevProToken");
    const DevCrowdsale = await ethers.getContractFactory("DevCrowdsale");

    [owner, addr1, addr2] = await ethers.getSigners();

    devProToken = await DevProToken.deploy(name, symobol, decimals, totalSupply);
    await devProToken.deployed();

    devCrowdsale = await DevCrowdsale.deploy(rate, wallet, devProToken.address);
    await devCrowdsale.deployed();

    await devProToken.transfer(devCrowdsale.address, ethers.utils.parseUnits("1000000", 18), { from: owner.address });

  });

  it("Crowdsale account has all token", async () => {
    balance = await devProToken.balanceOf(devCrowdsale.address);
    expect(balance).to.equal(ethers.utils.parseUnits("1000000", 18));
  });

})



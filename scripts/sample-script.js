// const ethers = require('ethers');
const hre = require("hardhat");

async function main() {

  const name = "DevProToken"
  const symobol = "DEV"
  const decimals = 18
  const totalSupply = ethers.utils.parseUnits("1000000", 18);
  const rate = 100;
  const wallet = '0x231464eF37dFBD7b3B9e55DaBAF79386910d82B3';
  let devProToken;
  let devCrowdsale;
  let devOpenProject;
  let owner;
  let addr1;
  let addr2;
  let addrs;

  const DevProToken = await ethers.getContractFactory("DevProToken");
  const DevCrowdsale = await ethers.getContractFactory("DevCrowdsale");
  const DevOpenProject = await ethers.getContractFactory("DevOpenProject");

  [owner, addr1, addr2] = await ethers.getSigners();

  // deployments
  devProToken = await DevProToken.deploy(name, symobol, decimals, totalSupply);
  await devProToken.deployed();

  devCrowdsale = await DevCrowdsale.deploy(rate, wallet, devProToken.address);
  await devCrowdsale.deployed();

  devOpenProject = await DevOpenProject.deploy(devProToken.address);
  await devOpenProject.deployed();

  // transfer token to crowdsale contract
  await devProToken.transfer(devCrowdsale.address, ethers.utils.parseUnits("1000000", 18), { from: owner.address });

  // buy token for address 1 
  await devCrowdsale.buyTokens(addr1.address, { value: ethers.utils.parseUnits("1", 18) });

  // balance for the dev pro token
  await devOpenProject.connect(addr1).claimMembership();
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

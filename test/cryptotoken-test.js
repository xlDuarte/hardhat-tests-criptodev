const { expect } = require("chai");
const { ethers } = require("hardhat");
const { it } = require("mocha");

describe("Greeter \n", function () {
  it("Should return the new greeting once it's changed", async function () {
    const Greeter = await ethers.getContractFactory("Greeter");
    const greeter = await Greeter.deploy("Hello, world!");
    await greeter.deployed();

    expect(await greeter.greet()).to.equal("Hello, world!");

    const setGreetingTx = await greeter.setGreeting(
      "Boa noite, galera CriptoDev!"
    );

    // wait until the transaction is mined
    await setGreetingTx.wait();

    expect(await greeter.greet()).to.equal("Boa noite, galera CriptoDev!");
  });
});

describe("\nChecking supply CryptoToken...", function () {
  supply = 1000;
  it("Checking supply: OK!", async function () {
    const cry = await ethers.getContractFactory("CryptoToken");

    const crydeply = await cry.deploy(supply);
    await crydeply.deployed();

    expect(await crydeply.totalSupply()).to.equal(supply);
  });

  it("Supply to owner: OK!", async function () {
    const [owner] = await ethers.getSigners();

    const cry = await ethers.getContractFactory("CryptoToken", owner);
    const crydeply = await cry.deploy(supply);
    await crydeply.deployed();

    expect(await crydeply.balanceOf(owner.address)).to.equal(supply);
  });

  describe("\nTransfer...", function () {
    supply = 1000;
    it("Transfer: OK!", async function () {
      const [owner, wallet1] = await ethers.getSigners();
      const cry = await ethers.getContractFactory("CryptoToken", owner);
      const crydeply = await cry.deploy(supply);
      await crydeply.deployed();

      await crydeply.transfer(wallet1.address, "500");

      expect(await crydeply.balanceOf(wallet1.address)).to.equal("500");
    });

    describe("\nAirdrop Test...", function () {
      supply = 1000;
      it("Subscribe Giveaway: OK!", async function () {
        const [owner] = await ethers.getSigners();
        const cry = await ethers.getContractFactory("CryptoToken", owner);
        const crydeply = await cry.deploy(supply);
        await crydeply.deployed();

        const air = await ethers.getContractFactory("Airdrop", owner);
        const airdeply = await air.deploy(crydeply.address);
        await airdeply.deployed();

        expect(await airdeply.subscribe()).to.be.ok;
      });
    });
  });
});

const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("TestFirst", function () {
  it("Stringtest------------", async function () {
    const Greeter = await ethers.getContractFactory("TestFirst");
    const greeter = await Greeter.deploy();
    const result1  = await greeter.trimMirroringChars();
    expect(result1).to.equal("appectricitear");
    console.log(result1);
    const result = await greeter.buildStringByTemplate(
      "number: {number}, account: {account}"
    );
    expect(result).to.equal("number: number, account: account");
    console.log(result);
  });
});

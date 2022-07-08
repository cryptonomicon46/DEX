const {expect} = require("chai");
const {  ethers } = require("hardhat");


describe("ERC20 Tests", function ()   {
    const INITIAL_SUPPLY = ethers.utils.parseEther('1000.0');
    const allowance = ethers.utils.parseEther("10");
    const allowance2 = ethers.utils.parseEther("100");

    // const allowance3 = ethers.utils.parseUnits("1");
    // console.log(allowance3,"ether")


    // const oneEther = ethers.BigNumber.from("1000000000000000000");
    // console.log(ethers.utils.formatUnits(oneEther,18))
    const balance = ethers.utils.parseEther("990")
    let ERC20Factory;
    let ERC20;
    let owner;
    let addr1;
    let addr2;


    beforeEach(async function ()  {
        ERC20Factory = await ethers.getContractFactory("ERC20");
        [owner,addr1, addr2, ...addrs] = await ethers.getSigners();
        ERC20 = await ERC20Factory.deploy(INITIAL_SUPPLY);
        // console.log(await ERC20.address);
        // console.log("Contract deployed at ",  ERC20.balanceOf[owner.address]);

      });
    

    it("Confirm Contract Address", async function () {
        console.log(`ERC20 contract deployed at ${await ERC20.address}`);
        // let originalAddres = await ERC20.connect(owner).getOriginalAddr();
        // expect(originalAddres).to.equal( ERC20.address);

    })

    it("Check total Supply", async function()  {
        let totalSupply = await ERC20.totalSupply();
        expect(totalSupply).to.equal(INITIAL_SUPPLY);

        await expect(ERC20.transfer(addr1.address, INITIAL_SUPPLY.add(1)))
        .to.be.revertedWith('Insufficient Balance!');

    })

    it("Check Initial Supply", async  function ()   {

        let ownerBalance = await ERC20.balances(owner.address);
        expect(ownerBalance).to.equal(INITIAL_SUPPLY)
    })

    it("Set Allowance for addr1 and check the Approval event", async function () {
        expect(await ERC20.approve(addr1.address,allowance))
        .to.emit(ERC20,'Approval').
        withArgs(owner.address,addr1.address, allowance);


        //Confirm Allowance
        let allow = await ERC20.allowance(owner.address,addr1.address)
        console.log(ethers.utils.formatUnits(allow,18))
        expect(allow).to.equal(allowance);


        //Transfer from Addr1 to Addr2 for the allowance amount
        let bal_owner_before = await ERC20.balances(owner.address);
        expect(bal_owner_before).to.equal(INITIAL_SUPPLY);
        console.log("BEFORE transfer:OWNER Bal:", ethers.utils.formatUnits(bal_owner_before,18))
        
        let bal_addr2_before = await ERC20.balances(addr2.address);
        expect(bal_addr2_before).to.equal(ethers.BigNumber.from("0"))
        console.log("BEFORE Transfer: ADDR2 Bal", ethers.utils.formatUnits(bal_addr2_before,18))




        await ERC20.connect(addr1).transferFrom(owner.address, addr2.address,allowance);
        let bal_addr2_after = await ERC20.balances(addr2.address);
        expect(bal_addr2_after).to.equal(allowance);
        console.log("AFTER Transfer: ADDR2 Bal", ethers.utils.formatUnits(bal_addr2_after,18))

        let bal_owner_after = await ERC20.balances(owner.address);
        expect(bal_owner_after).to.equal(INITIAL_SUPPLY.sub(allowance));
        console.log("AFTER transfer:OWNER Bal:", ethers.utils.formatUnits(bal_owner_after,18))

    });

    it("Mint tokens to Addr1", async function () {
        let totalSupply = await ERC20.totalSupply();

        console.log("TotalSupply Before Mint (ETH):",  ethers.utils.formatUnits(totalSupply,18))

        await ERC20.mint(addr1.address,allowance2);
        // let mintedAmt_BN = ethers.BigNumber.from(mintedAmt);
         totalSupply = await ERC20.totalSupply();
        expect(totalSupply).to.equal(INITIAL_SUPPLY.add(allowance2));
        console.log("TotalSupply After Mint (ETH):",  ethers.utils.formatUnits(totalSupply,18))

    })

    it("Burn tokens from Owner", async function () {
        let totalSupply = await ERC20.totalSupply();

        console.log("TotalSupply Before Mint (ETH):",  ethers.utils.formatUnits(totalSupply,18))

        await ERC20.burn(owner.address,allowance2);
        // let mintedAmt_BN = ethers.BigNumber.from(mintedAmt);
         totalSupply = await ERC20.totalSupply();
         expect(totalSupply).to.equal(INITIAL_SUPPLY.sub(allowance2));
         console.log("TotalSupply After Mint (ETH):",  ethers.utils.formatUnits(totalSupply,18))

    })


    it("Only Owner can mint", async function () {
       await expect( ERC20.connect(addr1.address).mint(owner.address,allowance2))
        .to.be.reverted;
    })

    it("Only Owner can burn", async function () {
      await  expect(ERC20.connect(addr1.address).burn(owner.address,allowance2))
        .to.be.reverted;
    })

})


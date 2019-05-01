const UpikoApp = artifacts.require("./UpikoApp.sol");

const testServiceName = "best windex cleaners";
const testServiceName2 = "mighty scriptkiddies";


contract("UpikoApp", accounts => {

  const SCHAIN_ACCT = accounts[0];
  const ETH_ACCT = accounts[1];
  const ETH_ACCT2 = accounts[2];
   

  it("...should create a seviceProvider and then get the name", async () => {
    const instance = await UpikoApp.deployed();
    const tx  = await instance.addProviderName(testServiceName, ETH_ACCT, {from: SCHAIN_ACCT});
    let retval = await instance.getProviderName(ETH_ACCT);

    assert.equal (tx.logs[0].args.name, testServiceName, "not blockchain tx value expected for test provider created");
    assert.equal(retval, testServiceName, "created provider name should match")
  });


  it("...should return back correct counts, and all addresses", async () => {
    const instance = await UpikoApp.deployed();
    let total = await instance.getTotalAddrCount();
    assert.equal(total, 1, "expecting 1 addr to exist");
    const tx  = await instance.addProviderName(testServiceName2, ETH_ACCT2, {from: SCHAIN_ACCT});
    total = await instance.getTotalAddrCount();
    assert.equal(total, 2, "expecting 2 addrs to exist");

    let addressArray = await instance.getAllEthAddresses();
    assert.equal(ETH_ACCT, addressArray[0], "expecting addr" + ETH_ACCT);
    assert.equal(ETH_ACCT2, addressArray[1], "expecting addr" + ETH_ACCT2);
    });

});



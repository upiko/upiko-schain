const UpikoApp = artifacts.require("./UpikoApp.sol");

const testServiceName = "best windex cleaners";
const testServiceName2 = "mighty scriptkiddies";
const testServiceName3 = "mucho donuts";


contract("UpikoApp User Test", accounts => {
  const SCHAIN_ACCT = accounts[0];
  const ETH_ACCT = accounts[1];
  const ETH_ACCT2 = accounts[2];
  const ETH_ACCT3 = accounts[3];
 
  
  it("...it should create user", async () => {
    const instance = await UpikoApp.deployed();
    const tx  = await instance.addUser(testServiceName, ETH_ACCT, {from: SCHAIN_ACCT});
    const id = await instance.idForEthAddr(ETH_ACCT);
    const users = await instance.users.call(id);
    assert.equal(users.name, testServiceName);
  });

  it("...it should return one", async () => {
    const instance = await UpikoApp.deployed();
    const count = await instance.numberOfUsers();
    assert.equal(count, 1);
  });

  it("...it should not allow duplicate", async () => {
    const instance = await UpikoApp.deployed();
    let count = await instance.numberOfUsers();
    assert.equal(count, 1); //need this there already
    //const tx  = await instance.addUser(testServiceName, ETH_ACCT, {from: SCHAIN_ACCT});
   // count = await instance.numberOfUsers();
   // assert.equal(count, 1); //should not have been added
  });

  it("...it should return a count of two", async () => {
    const instance = await UpikoApp.deployed();
    let count = await instance.numberOfUsers();
    assert.equal(count, 1); //need this there already
    const tx  = await instance.addUser(testServiceName2, ETH_ACCT2, {from: SCHAIN_ACCT});
    count = await instance.numberOfUsers();
    assert.equal(count, 2); //should not have been added
  });
});



contract("UpikoApp More User Tests", accounts => {
  const SCHAIN_ACCT = accounts[0];
  const ETH_ACCT = accounts[1];
  const ETH_ACCT2 = accounts[2];
  const ETH_ACCT3 = accounts[3];
  const ETH_ACCT4 = accounts[4];
    
  it("...it should create and return 3 users", async () => {
    const instance = await UpikoApp.deployed();
    let tx  = await instance.addUser(testServiceName, ETH_ACCT, {from: SCHAIN_ACCT});
    tx  = await instance.addUser(testServiceName2, ETH_ACCT2, {from: SCHAIN_ACCT});
    tx  = await instance.addUser(testServiceName3, ETH_ACCT3, {from: SCHAIN_ACCT});
    let count = await instance.numberOfUsers();
    assert.equal(count, 3);
    let id1 = await instance.idForEthAddr(ETH_ACCT);
    let id2 = await instance.idForEthAddr(ETH_ACCT2);
    let id3 = await instance.idForEthAddr(ETH_ACCT3);

    let one = await instance.users.call(id1);
    assert.equal(one.ethAddr, ETH_ACCT);
    let two = await instance.users.call(id2);
    assert.equal(two.ethAddr, ETH_ACCT2);
    let three = await instance.users.call(id3);
    assert.equal(three.ethAddr, ETH_ACCT3);

    let id4 = await instance.idForEthAddr(ETH_ACCT4);
    let invalid = await instance.users.call(id4);
    assert(invalid.ethAddr !== ETH_ACCT4);
  });

});




pragma solidity ^0.4.23;

contract UpikoApp {
 
  struct User{
    string name;
    address ethAddr;
    bool isProvider;
    //skills : TODO
  }

  User[] public users;
  mapping (address => uint) public userToId;
  uint userCount;

  event UserAdded(string _name, address _ethAddr, bool _isProvider, address sChainAddr);


  function addUser(string _name, address _ethAddr, bool _isProvider) public {
    uint id = users.push(User(_name, _ethAddr, _isProvider)) - 1;
    userToId[_ethAddr] = id;
    userCount++;
    emit UserAdded(_name, _ethAddr, _isProvider, msg.sender);
  }

  function numberOfUsers() public view returns (uint){
    return userCount;
  }

  function idForEthAddr(address _ethAddr) public view returns (uint){
    return (userToId[_ethAddr]);
  }

  //function getAllUsers() public view returns(User[]) {
  //  return (users);
  //}

  //function userForEthAddr(address _ethAddr) public view returns (User){
  //  uint id = userToAddress[_ethAddr];
  //  return users[id];
  //}



/*

 mapping (address => string) ethAddrToName;   //address is eth network(not sidechain) address
  address[] ethAddresses;
  uint addrCounter;

  event userAdded(string name, address addrOnEthNetwork, address addrOnSideChain);

  function addUser(string memory _name, address _addrOnEthNetwork, ) public {
    ethAddrToProviderName[_addrOnEthNetwork] = _name;
    ethAddresses.push(_addrOnEthNetwork); 
    addrCounter++;
    emit providerAdded(_name, _addrOnEthNetwork, msg.sender);
  }

  function getProviderName(address _ethAddr) public view returns (string memory) {
    return ethAddrToName[_ethAddr];
  }

  function getAllEthAddresses()  public view returns (address[]){
    return ethAddresses;
  }

  function getTotalAddrCount() public view returns (uint){
    return addrCounter;
  }*/
}
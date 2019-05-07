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
}
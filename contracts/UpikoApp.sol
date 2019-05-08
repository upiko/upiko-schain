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


  event UserAdded(string _name, address _ethAddr, bool _isProvider, address sChainAddr);


  modifier onlyOne(address _ethAddr) {
   // uint id = userToId[_ethAddr];
  //require(id < 0, "cannot create another user for this address, you can call update");
    _;
  }


  function addUser(string _name, address _ethAddr, bool _isProvider) public onlyOne(_ethAddr){
    uint id = users.push(User(_name, _ethAddr, _isProvider)) - 1;
    userToId[_ethAddr] = id;
    emit UserAdded(_name, _ethAddr, _isProvider, msg.sender);
  }

  function numberOfUsers() public view returns (uint){
    return users.length;
  }

  function idForEthAddr(address _ethAddr) public view returns (uint){
    return (userToId[_ethAddr]);
  }
}
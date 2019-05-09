pragma solidity ^0.4.23;

contract UpikoApp {
 
  struct User{
    string name;
    address ethAddr;
    bool isProvider;
    //skills : TODO
  }

  struct Skill{
    string skillName;
  }

  struct Sos {
    string description;
    Skill[] skills;
  }

 
  Skill[] public skillsList;
  User[] public users;
  mapping (address => uint) public userToId;
  mapping (string => uint) skillNameToIndex;
  

  constructor() public{
    addSkill("Javascript");
    addSkill("Typescript");
    addSkill("React");
    addSkill("Solidity");
  }


  /* User */

  event UserAdded(string _name, address _ethAddr, bool _isProvider, address sChainAddr);
 

  modifier onlyOne(address _ethAddr) {
    uint id = userToId[_ethAddr];
    // require(users[id].ethAddr != _ethAddr, "Ethereum address already in use");
    _;
  }

  modifier noRepeats(string _skillName){
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


  /* SoS */
   event SkillAdded(string _skillName);

  function numberOfSkills() public view returns (uint){
    return skillsList.length;
  }

  function addSkill(string _skillName) public noRepeats(_skillName) {
    uint index = skillsList.push(Skill(_skillName)) - 1;
    skillNameToIndex[_skillName] = index;
    emit SkillAdded(_skillName);
  }

}
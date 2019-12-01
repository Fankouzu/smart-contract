pragma solidity ^0.5.12;

import "./ownable.sol";
import "./safemath.sol";

contract ZombieFactory is Ownable {

  using SafeMath for uint256;

  event NewZombie(uint zombieId, string name, uint dna);

  uint dnaDigits = 16;
  uint dnaModulus = 10 ** dnaDigits;
  uint public cooldownTime = 1 days;
  uint public zombiePrice = 0.01 ether;
  uint public zombieCount = 0;

  struct Zombie {
    string name;
    uint dna;
    uint16 winCount;
    uint16 lossCount;
    uint32 level;
    uint32 readyTime;
  }

  Zombie[] public zombies;

  mapping (uint => address) public zombieToOwner;
  mapping (address => uint) ownerZombieCount;
  mapping (uint => uint) public zombieFeedTimes;

  function _createZombie(string memory _name, uint _dna) internal {
    uint id = zombies.push(Zombie(_name, _dna, 0, 0, 1, 0)) - 1;
    zombieToOwner[id] = msg.sender;
    ownerZombieCount[msg.sender] = ownerZombieCount[msg.sender].add(1);
    zombieCount = zombieCount.add(1);
    emit NewZombie(id, _name, _dna);
  }

  function _generateRandomDna(string memory _str) private view returns (uint) {
    return uint(keccak256(abi.encodePacked(_str,now))) % dnaModulus;
  }

  function createZombie(string memory _name) public{
    require(ownerZombieCount[msg.sender] == 0);
    uint randDna = _generateRandomDna(_name);
    randDna = randDna - randDna % 10;
    _createZombie(_name, randDna);
  }

  function buyZombie(string memory _name) public payable{
    require(ownerZombieCount[msg.sender] > 0);
    require(msg.value >= zombiePrice);
    uint randDna = _generateRandomDna(_name);
    randDna = randDna - randDna % 10 + 1;
    _createZombie(_name, randDna);
  }

  function setZombiePrice(uint _price) external onlyOwner {
    zombiePrice = _price;
  }

}

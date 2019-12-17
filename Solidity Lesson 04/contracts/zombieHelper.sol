pragma solidity ^0.5.12;

import "./zombieFactory.sol";

contract ZombieHelper is ZombieFactory {

  uint public levelUpFee = 0.001 ether;

  modifier aboveLevel(uint _level, uint _zombieId) {
    require(zombies[_zombieId].level >= _level,'Level is not sufficient');
    _;
  }
  modifier onlyOwnerOf(uint _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId],'Zombie is not yours');
    _;
  }
  function setLevelUpFee(uint _fee) external onlyOwner {
    levelUpFee = _fee;
  }

  function levelUp(uint _zombieId) external payable onlyOwnerOf(_zombieId){
    require(msg.value == levelUpFee,'No enough money');
    zombies[_zombieId].level++;
  }

  function changeName(uint _zombieId, string calldata _newName) external  aboveLevel(2, _zombieId) onlyOwnerOf(_zombieId) {
    zombies[_zombieId].name = _newName;
  }

  function getZombiesByOwner(address  _owner) external view returns(uint[] memory) {
    uint[] memory result = new uint[](ownerZombieCount[_owner]);
    uint counter = 0;
    for (uint i = 0; i < zombies.length; i++) {
      if (zombieToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

  function _triggerCooldown(Zombie storage _zombie) internal {
    _zombie.readyTime = uint32(now + cooldownTime) - uint32((now + cooldownTime) % 1 days);
  }

  function _isReady(Zombie storage _zombie) internal view returns (bool) {
      return (_zombie.readyTime <= now);
  }

  function multiply(uint _zombieId, uint _targetDna) internal onlyOwnerOf(_zombieId) {
    Zombie storage myZombie = zombies[_zombieId];
    require(_isReady(myZombie),'Zombie is not ready');
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    newDna = newDna - newDna % 10 + 9;
    _createZombie("NoName", newDna);
    _triggerCooldown(myZombie);
  }


}

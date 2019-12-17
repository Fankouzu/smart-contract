pragma solidity ^0.5.12;

import "./zombieOwnership.sol";

contract ZombieMarket is ZombieOwnership {
    struct zombieSales{
        address payable seller;
        uint price;
    }
    mapping(uint=>zombieSales) public zombieShop;
    uint shopZombieCount;
    uint public tax = 1 finney;
    uint public minPrice = 1 finney;

    event SaleZombie(uint indexed zombieId,address indexed seller);
    event BuyShopZombie(uint indexed zombieId,address indexed buyer,address indexed seller);

    function saleMyZombie(uint _zombieId,uint _price)public onlyOwnerOf(_zombieId){
        require(_price>=minPrice+tax,'Your price must > minPrice+tax');
        zombieShop[_zombieId] = zombieSales(msg.sender,_price);
        shopZombieCount = shopZombieCount.add(1);
        emit SaleZombie(_zombieId,msg.sender);
    }
    function buyShopZombie(uint _zombieId)public payable{
        require(msg.value >= zombieShop[_zombieId].price,'No enough money');
        _transfer(zombieShop[_zombieId].seller,msg.sender, _zombieId);
        zombieShop[_zombieId].seller.transfer(msg.value - tax);
        delete zombieShop[_zombieId];
        shopZombieCount = shopZombieCount.sub(1);
        emit BuyShopZombie(_zombieId,msg.sender,zombieShop[_zombieId].seller);
    }
    function getShopZombies() external view returns(uint[] memory) {
        uint[] memory result = new uint[](shopZombieCount);
        uint counter = 0;
        for (uint i = 0; i < zombies.length; i++) {
            if (zombieShop[i].price != 0) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

    function setTax(uint _value)public onlyOwner{
        tax = _value;
    }
    function setMinPrice(uint _value)public onlyOwner{
        minPrice = _value;
    }
}

pragma solidity ^0.5.12;

import "./zombieOwnership.sol";

contract ZombieMarket is ZombieOwnership {
    struct zombieSales{
        address payable seller;
        uint price;
    }
    mapping(uint=>zombieSales) public zombieShop;
    uint public tax = 1 finney;
    uint public minPrice = 1 finney;

    event SaleZombie(uint indexed zombieId,address indexed seller);
    event BuyShopZombie(uint indexed zombieId,address indexed buyer,address indexed seller);

    function saleMyZombie(uint _zombieId,uint _price)public onlyOwnerOf(_zombieId){
        require(_price>=minPrice+tax);
        zombieShop[_zombieId] = zombieSales(msg.sender,_price);
        emit SaleZombie(_zombieId,msg.sender);
    }
    function buyShopZombie(uint _zombieId)public payable{
        require(msg.value >= zombieShop[_zombieId].price);
        _transfer(zombieShop[_zombieId].seller,msg.sender, _zombieId);
        zombieShop[_zombieId].seller.transfer(msg.value - tax);
        delete zombieShop[_zombieId];
        emit BuyShopZombie(_zombieId,msg.sender,zombieShop[_zombieId].seller);
    }
    function setTax(uint _value)public onlyOwner{
        tax = _value;
    }
    function setMinPrice(uint _value)public onlyOwner{
        minPrice = _value;
    }
}

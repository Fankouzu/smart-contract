pragma solidity ^0.5.12;

import "./zombieOwnership.sol";

contract ZombieMarket is ZombieOwnership {
    struct zombieSales{
        address payable seller;
        uint128 price;
    }
    mapping(uint=>zombieSales) public zombieShop;
    uint public tax = 1 finney;
    uint public minPrice = 1 finney;

    event SaleZombie(uint indexed zombieId,address indexed seller);
    event BuyShopZombie(uint indexed zombieId,address indexed buyer,address indexed seller);

    function saleMyZombie(uint _zombieId,uint128 _price)public onlyOwnerOf(_zombieId){
        require(_price>=minPrice+tax);
        zombieShop[_zombieId] = zombieSales(msg.sender,_price);
        emit SaleZombie(_zombieId,msg.sender);
    }
    function buyShopZombie(uint _zombieId)public payable{
        zombieSales memory _zombieSales = zombieShop[_zombieId];
        require(msg.value >= _zombieSales.price);
        _transfer(_zombieSales.seller,msg.sender, _zombieId);
        _zombieSales.seller.transfer(msg.value - tax);
        delete zombieShop[_zombieId];
        emit BuyShopZombie(_zombieId,msg.sender,_zombieSales.seller);
    }
    function setTax(uint _value)public onlyOwner{
        tax = _value;
    }
    function setMinPrice(uint _value)public onlyOwner{
        minPrice = _value;
    }
}

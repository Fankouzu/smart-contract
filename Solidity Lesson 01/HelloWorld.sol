pragma solidity >=0.4.22 <0.6.0;

contract HelloWorld{
    string _name;
    function setName(string name) public{
        _name = name;
    }
    function getName() constant public returns(string){
        return _name;
    }
}
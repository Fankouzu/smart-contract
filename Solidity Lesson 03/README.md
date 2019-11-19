# 以太坊智能合约课
## 第03课--开发环境部署

### 1.安装Truffle
#### Truffle中文文档地址：
>https://learnblockchain.cn/docs/truffle/index.html
#### 1.安装 Truffle：

```shell
npm install -g truffle
```
#### 2.安装HDWalletProvider
```shell
npm install truffle-hdwallet-provider
```
#### 3.新建项目文件夹
```shell
mkdir myProject    
cd myProject
```
#### 4.安装Openzeppelin
```shell
npm install @openzeppelin/contracts
```
#### 5.创建Token.sol
```shell
vim Token.sol
```
```javascript
pragma solidity ^0.5.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";
contract ExampleToken is ERC20, ERC20Detailed {
  constructor () public
  ERC20Detailed("CuiToken", "CUI", 18){
    _mint(msg.sender,10000 * (10 ** uint256(decimals())));
  }
}
```
#### 6.获取MetaMask助记词
![map](https://github.com/Fankouzu/smart-contact/raw/master/Solidity%20Lesson%2003/metamask.jpg)
oppose say prevent raven mystery fiber program pupil poverty else pill enact

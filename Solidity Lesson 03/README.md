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
truffle init
```
#### 4.安装Openzeppelin
```shell
npm install @openzeppelin/contracts
```
#### 5.创建Token.sol
```shell
vim contracts/Token.sol
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
#### 6.获取Ropsten测试币
##### 获取地址：
>https://faucet.ropsten.be/

![map](https://github.com/Fankouzu/smart-contact/raw/master/Solidity%20Lesson%2003/faucet.jpg)
#### 7.获取MetaMask助记词
![map](https://github.com/Fankouzu/smart-contact/raw/master/Solidity%20Lesson%2003/metamask.jpg)
#### 8.注册Infura，获取测试网或主网的KEY
##### 地址：
>https://infura.io/

![map](https://github.com/Fankouzu/smart-contact/raw/master/Solidity%20Lesson%2003/infura.jpg)
#### 9.修改truffle-config.js文件
```shell
vim truffle-config.js
```
```javascript
var HDWalletProvider = require("truffle-hdwallet-provider");  // 导入模块
var mnemonic = "oppose say prevent raven mystery fiber program pupil poverty else pill enact";  //MetaMask的助记词。

module.exports = {
  	networks: {
        ropsten: {
            provider: function() {
                // mnemonic表示MetaMask的助记词。 "ropsten.infura.io/v3/33..."表示Infura上的项目id
                return new HDWalletProvider(mnemonic, "ropsten.infura.io/v3/e1bb25c2b20b4b5383517028056c89a3", 1);   // 0表示第二个账户(从0开始)
            },
            network_id: "*",  // match any network
            gas: 3012388,
            gasPrice: 30000000000
        },
  	}
};
```

#### 10.编译
```shell
truffle compile
```
#### 11.创建文件
```shell
vim migrations/2_deploy_contracts.js
```
```javascript
const ExampleToken = artifacts.require("ExampleToken");

module.exports = function(deployer) {
  deployer.deploy(ExampleToken);
};
```
#### 12.部署
```shell
truffle migrate
```
#### 13.合约调用
```javascript
var myCoin
ExampleToken.deployed().then(function(instance){myCoin=instance})
```

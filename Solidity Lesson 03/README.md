# 以太坊智能合约课
## 第03课--部署智能合约

### 1.部署到Truffle
#### Truffle中文文档地址：
>https://learnblockchain.cn/docs/truffle/index.html
#### 1.安装 Truffle：
```shell
npm install -g truffle
```
#### 2.新建项目文件夹
```shell
mkdir myProject    
cd myProject
truffle init
```
#### 3.安装Openzeppelin
```shell
npm install @openzeppelin/contracts
```
#### 4.创建Token.sol
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
    _mint(msg.sender,10000000000 * (10 ** uint256(decimals())));
  }
}
```
#### 5.编译
```shell
truffle compile
```
#### 6.创建文件
```shell
vim migrations/2_deploy_contracts.js
```
```javascript
const ExampleToken = artifacts.require("ExampleToken");

module.exports = function(deployer) {
  deployer.deploy(ExampleToken);
};
```
#### 7.部署到Truffle develop
```shell
truffle develop
```
```shell
migrate
```
#### 8.合约调用
```javascript
var myCoin
ExampleToken.deployed().then(function(instance){myCoin=instance})
```

### 2.部署到Ganache
#### 1.修改truffle-config.js文件
```shell
vim truffle-config.js
```
```javascript

module.exports = {
  	networks: {
      development: {
        host: "192.168.1.30",     // Localhost (default: none)
        port: 7545,            // Standard Ethereum port (default: none)
        network_id: "*",       // Any network (default: none)
      },
    }
};
```

#### 2.部署到Ganache
```shell
truffle console
```
```shell
migrate
```
#### 3.合约调用
```javascript
var myCoin
ExampleToken.deployed().then(function(instance){myCoin=instance})
```



### 3.部署到Ropsten
#### 1.安装HDWalletProvider
```shell
npm install @truffle/hdwallet-provider
```
#### 2.获取Ropsten测试币
##### 获取地址：
>https://faucet.ropsten.be/

![map](https://raw.githubusercontent.com/Fankouzu/smart-contract/master/Solidity%20Lesson%2003/faucet.jpg)
#### 3.获取MetaMask助记词
![map](https://raw.githubusercontent.com/Fankouzu/smart-contract/master/Solidity%20Lesson%2003/metamask.jpg)
#### 4.注册Infura，获取测试网或主网的KEY
##### 地址：
>https://infura.io/

![map](https://raw.githubusercontent.com/Fankouzu/smart-contract/master/Solidity%20Lesson%2003/infura.jpg)
#### 5.修改truffle-config.js文件
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
                return new HDWalletProvider(mnemonic, "https://ropsten.infura.io/v3/e1bb25c2b20b4b5383517028056c89a3", 1);   // 0表示第二个账户(从0开始)
            },
            network_id: "*",  // match any network
            gas: 3012388,
            gasPrice: 20000000000,
            confirmations: 2,    // # of confs to wait between deployments. (default: 0)
            timeoutBlocks: 200,  // # of blocks before a deployment times out  (minimum/default: 50)
            skipDryRun: true     // Skip dry run before migrations? (default: false for public nets )
        },
  	}
};
```

#### 6.部署
```shell
truffle migrate  --network ropsten
```
#### 7.合约调用
```shell
truffle console --network ropsten
```
```javascript
var myCoin
ExampleToken.deployed().then(function(instance){myCoin=instance})
```


 
### 4.部署到主网
#### 1.修改truffle-config.js文件
```shell
vim truffle-config.js
```
```javascript
var HDWalletProvider = require("@truffle/hdwallet-provider");  // 导入模块
var mnemonic_mainnet = "主网助记词";  //MetaMask的助记词。

module.exports = {
  	networks: {
      mainnet: {
        provider: new HDWalletProvider(mnemonic_mainnet, "https://mainnet.infura.io/e1bb25c2b20b4b5383517028056c89a3"),
        network_id: 1,
        gas: 3012388,
        gasPrice: 20000000000,
        confirmations: 2,    // # of confs to wait between deployments. (default: 0)
        timeoutBlocks: 200,  // # of blocks before a deployment times out  (minimum/default: 50)
        skipDryRun: true     // Skip dry run before migrations? (default: false for public nets )
      }
  	}
};
```
#### 2.部署
```shell
truffle migrate  --network mainnet
```
#### 3.合约调用
```shell
truffle console --network mainnet
```
```javascript
var myCoin
ExampleToken.deployed().then(function(instance){myCoin=instance})
```

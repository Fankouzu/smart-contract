# 以太坊web3前端开发课
## 实战2

- 定义Provider
- 实例化Web3
- 实例化合约
- 与合约交互

### 前端代码与以太坊交互分五步

- 一个实例化的provider,可以是metamask,infura,truffle,ganache,或者搭建以太坊节点
- 合约的abi,自己编写的合约通过编译后获得abi,链上的合约需要开源才能获得abi,erc20代币合约的abi都一样
- 实例化web3.js或者ethers.js
- 通过abi和合约地址将合约实例化
- 调用合约方法,call或者send

### 修改上节课的react代码中的App.js
```javascript
import React, { Component } from 'react';
import Web3 from "web3";
class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      value:0
    };
  }
  async componentDidMount() {
    //判断页面是否安装Metamask
    if (typeof window.ethereum !== 'undefined') {
      const ethereum = window.ethereum
      //禁止自动刷新，metamask要求写的
      ethereum.autoRefreshOnNetworkChange = false

      try {
        //第一次链接Metamask
        const accounts = await ethereum.enable()
        console.log(accounts)
        //初始化Provider
        const provider = window['ethereum']
        console.log(provider)
        //获取网络ID
        console.log(provider.chainId)
        //实例化Web3
        const web3 = new Web3(provider)
        console.log(web3)
        //导入abi文件
        const abi = require("./contract.abi.json")
        //定义合约地址
        const address = "0x439b911d6423255a515d9762e966985d206cc177"
        //实例化合约
        window.myContract = new web3.eth.Contract(abi.abi,address)
        console.log(window.myContract)
        window.defaultAccount = accounts[0].toLowerCase()
        console.log(window.defaultAccount)

        ethereum.on('accountsChanged', function (accounts) {
          console.log("accountsChanged:" + accounts)
        })
        ethereum.on('networkChanged', function (networkVersion) {
          console.log("networkChanged:" + networkVersion)
        })
      } catch (e) {

      }
    } else {
      console.log('没有metamask')
    }
  }
  Getter = () => {
    window.myContract.methods.value().call().then(value=>{
      console.log(value)
      this.setState({value:value})
    })
  }
  Increase = () => {
    window.myContract.methods.increase(1).send({from:window.defaultAccount})
    .on('transactionHash',(transactionHash)=>{
      console.log('transactionHash',transactionHash)
    })
    .on('confirmation',(confirmationNumber,receipt)=>{
      console.log({ confirmationNumber: confirmationNumber, receipt: receipt })
    })
    .on('receipt',(receipt)=>{
      console.log({ receipt: receipt })
    })
    .on('error',(error,receipt)=>{
      console.log({ error: error, receipt: receipt })
    })
  }
  render() {
    return (
      <div>
        <div>{this.state.value}</div>
        <div>
          <button onClick={() => { this.Getter() }}>Getter</button>
        </div>
        <div>
          <button onClick={() => { this.Increase() }}>Increase</button>
        </div>
        <div></div>
      </div>
    );
  }
}

export default App;
```
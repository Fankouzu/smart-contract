# 以太坊web3前端开发课

## 实战1
- 链接Metamask
- 定义Provider
- 实例化Web3
- 读取Metamask的当前账号和网络ID
- 切换网络
### 初始化项目,如果没有create-react-app请先安装
```
npx create-react-app my-web3
cd my-web3
npm start
```
### 安装web3
```
yarn add web3
```
### 修改App.js

```javascript

import React, { Component } from 'react';
import Web3 from "web3";
class App extends Component {
  constructor(props) {
    super(props);
    this.state = {};
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
  render() {
    return (
      <div></div>
    );
  }
}

export default App;

```
### 运行代码
```
yarn start
```


## Web3中文文档
- https://learnblockchain.cn/docs/web3js-0.2x/index.html
## Metamask文档
- https://docs.metamask.io/guide/getting-started.html

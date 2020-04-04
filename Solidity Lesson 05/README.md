# 以太坊web3前端开发课

## 实战1
- 链接Metamask
- 定义Provider
- 实例化Web3
- 读取Metamask的当前账号和网络ID
- 切换网络

 
```javascript

import Web3 from "web3";

if (typeof window.ethereum !== 'undefined') {
    const ethereum = window.ethereum
    //禁止自动刷新，metamask要求写的
    ethereum.autoRefreshOnNetworkChange = false

    try {
        //链接Metamask
        const accounts = await ethereum.enable()
        //当前地址
        console.log(accounts)
        //定义Provider 
        const provider = window['ethereum']
        console.log(provider)
        //当前网络id
        console.log(provider.chainId)
        //实例化web3
        const web3 = new Web3(provider)
        console.log(web3)
        //监听切换账号
        ethereum.on('accountsChanged', function (accounts) {
            console.log("accountsChanged:"+accounts)
        })
        //监听切换网络
        ethereum.on('networkChanged', function (networkVersion) {
            console.log("networkChanged:"+networkVersion)
        })
    } catch (error) {
        console.error(error)
    }
}else{
}

```

## Web3中文文档
- https://learnblockchain.cn/docs/web3js-0.2x/index.html
## Metamask文档
- https://docs.metamask.io/guide/getting-started.html

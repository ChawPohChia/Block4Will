# block4will

## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

### Compiles and minifies for production
```
npm run build
```

### Lints and fixes files
```
npm run lint
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).


Others:
--------
References:
1) Vue for Beginner 2019, https://www.youtube.com/watch?v=4deVCNJq3qc
2) Adding Boostratp to Vue ,https://travishorn.com/adding-bootstrap-to-a-vue-cli-project-98c2a30e0ed0
3) Create router in Vue: 
    - https://www.codingame.com/playgrounds/3808/how-to-use-vue-router
    - The above not successful ,use "vue add router instead"
       https://router.vuejs.org/installation.html#npm 

4) Refers to  https://willcraftnow.com/en/online_wills for Will format

5) Bootstrap Form creation references: https://www.w3schools.com/bootstrap/bootstrap_forms_inputs.asp

6) Upload images references:    
   https://stackoverflow.com/questions/49106045/preview-an-image-before-it-is-uploaded-vuejs


IPFS
----
1) Webpage seve from port 8080, so have to configure ipfs server from 8090
   https://discuss.ipfs.io/t/can-i-change-the-port-ipfs-works-on/5565 
   Change it from: ~/.ipfs/config
   * To run IPFS: > ipfs daemon
2) For writing and retriving of files have been refering to MI4 4-1


REMIX
-----
Find the relevant smart contract in:https://remix.ethereum.org/
WillRegistry.sol


Deployment of Smart Contract
----------------------------
A: Deployment to Rospten Testnet(Refer to Ex3-3)
   1) Use MEW website -> Deploy Contract
   2) Compile Smart Contract typed in Remix.org, copy Bytecode of Smart Contract
   3) Paste Bytecode into MEW ->Deploy Smart Contract, Gas fee appear, deploy it with agreed Gas fee
   4) Go to Rosten.etherscan.io put in metamask main wallet address, to check the deployed contract and the deployed contract address
   5) Using ropsten.etherscan.io -> "Interact with contract" 
   6) Put in (a)contract address (b)ByteCode (b)ABI/JSON Interface, click access...then can select the functions of cotract already.  
   7) Gas fee: 650198, deploy using address: 0xa8CE0a182Eb345cc9db806bf8991d9e94e129737
   8) Go to https://ropsten.etherscan.io/ check for contract deployment and address.
   9) Deployment Details: https://ropsten.etherscan.io/
   0xded524e51686b9e5bff421fbaec7de43d2f66b9b22d0df76bc62c9023dc49aac	8991055	2 mins ago	0xa8ce0a182eb345cc9db806bf8991d9e94e129737	 IN 	 Contract Creation	0 Ether	0.000650198
  `10) Deployed WillRegistryV1 contract address: 0x473a514f40FD105D980Cbca33A7Ca3fb28992F75
   11) Try using MEW website to do "Interact with Wallet", put in (a)contract address (b)ABI
   12) Upload Will function will spend: 149972 Gas fee 


B. Connect to MEW Wallet using Metamask account: (using common m password)
   https://www.myetherwallet.com, after open MEW wallet using Metamask will see the webpage loaded with account balance. 


Contract Address for WillRegistryV1.sol
---------------------------------------



C: Access using Web3.JS



Others:
1) No Longer Injecting web3.js: https://medium.com/metamask/no-longer-injecting-web3-js-4a899ad6e59e

2) How to Connect Web3.js to MetaMask in 2020: https://medium.com/@awantoch/how-to-connect-web3-js-to-metamask-in-2020-fee2b2edf58a


smart Contract Testing 
----------------------
1) Using Solidity Unit Testing.refer to here:
https://medium.com/remix-ide/solidity-unit-testing-using-remix-tests-part-2-50a9f486ab5d 

2) Sample testing examples:
https://remix-ide.readthedocs.io/en/latest/unittesting_examples.html#simple-example





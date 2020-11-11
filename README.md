# Block4will
## This is a project that intends to let will writer to persist his written will into Ethereum blockchain. And to retrive it using a will hash that guarantee data integrity of the will. Executor image is persisted to IPFS to save gas fees.


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


### Remarks
To npm run serve this project, make sure the following prerequisite:
1) With metamask installed in web browser, making sure you have wallet and gas.
2) Need to run ipfs in the background >ipfs daemon 

### Brief Architecture of B4W
Chrome with Metamask installed
localhost:8080/blockwill        
--> Sending will info to smart contract address 0x473a514f40FD105D980Cbca33A7Ca3fb28992F75
    - willHash = sha256(JSON.stringify(this.form)); // to guarantee data integrity, as a searching key in storage also.
    - contract.methods
          .upload(
            willHash,            
            this.form.personaldetails.details,
            this.form.assetallocations.allocations,
            this.form.executor.executorIpfsImageHash
          )

--> Retriving info from deployed smart contract 
    - contract.methods.getWill(this.form.retrieveWillHash).call({
               from: window.web3.eth.defaultAccount}).then(async (res) => {
               //Return format: Wills[i].personalDetail,Wills[i].assetAllocation, Wills[i].executorImageIpfsHash, Wills[i].dateAddedIntoSmartContract, 
            
               this.form.personaldetails.details=res[0];  
               this.form.assetallocations.allocations=res[1]; 
               this.form.executorImageHash=res[2];
               this.RetrieveExecutorImage(this.form.executorImageHash);
               );

## IPFS setup
1) Webpage serve from port 8080, so have to configure ipfs server from 8090
   https://discuss.ipfs.io/t/can-i-change-the-port-ipfs-works-on/5565 
   Change it from: ~/.ipfs/config
   * To run IPFS: > ipfs daemon
2) Writing and retriving of files to/from IPFS have been refereing to MI4 4-1


### Smart Contract and Unit Test Written in REMIX 
1) IDE: https://remix.ethereum.org/
   a) WillRegistry.sol
   b) WillRegistry_test.sol

2) Smart Contract Deployment Address:
   0x473a514f40FD105D980Cbca33A7Ca3fb28992F75
   https://ropsten.etherscan.io/address/0x473a514f40FD105D980Cbca33A7Ca3fb28992F75


### Deployment of Smart Contract
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


### Sample will hashes to test out "RetrieveWill":
1) fe056be56a6ec138557fec2da99055445cbf4739e9f18a4c5da24c561556a35d
2) 5c9c5ec87bbd935216d6c4ef41a9b20fa0b4f9e71af8cc5492c2d278b1c6cd0f


### References Have Been Used to Create this Project:
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

7) For Smart Contract Testing: 
   a) Using Solidity Unit Testing.refer to here:
https://medium.com/remix-ide/solidity-unit-testing-using-remix-tests-part-2-50a9f486ab5d a
   b) Sample testing examples:
https://remix-ide.readthedocs.io/en/latest/unittesting_examples.html#simple-example

8) No Longer Injecting web3.js: https://medium.com/metamask/no-longer-injecting-web3-js-4a899ad6e59e

9) How to Connect Web3.js to MetaMask in 2020: https://medium.com/@awantoch/how-to-connect-web3-js-to-metamask-in-2020-fee2b2edf58a 

10)Connect to MEW Wallet using Metamask account:
   https://www.myetherwallet.com, after open MEW wallet using Metamask will see the webpage loaded with account balance. 

11) Unit testing of contract:
https://remix.ethereum.org/#optimize=false&evmVersion=null&version=soljson-v0.4.26+commit.4563c3fc.js


### Area for improvements
1) More complete input and output for will writer.
2) Will writing is not just technical implementation, need to have national law to support or to give standard for implementation.
3) How to make sure the will writer is the actual will owner? (e.g. may request persistance of biometrics data, but privacy issue?)
4) Data integrity verification at the retrieval page.
5) Versioning of will (making sure the sender with only one most updated will)
6) Auto execution of will, upon Death Registratation Agency announces death of will owner, will will be autoreleased to executor. 
7) User has to install metamask extension and ipfs.
8) Create Willcoin to tokenize this solution.
9) Assessors comments
   a) Use a mapping rather than a struct.
   b) Can consider to let user to deposit their digital currency, upon death announced, to distribute to stack holder automatically.
   c) May hit the contact size limit, said 1 million will insides, how to resolve?
   d) To have form checking before activate the submit button., and other reasonable UI checking.





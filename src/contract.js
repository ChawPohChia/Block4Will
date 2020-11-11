const contractAddress = "0x473a514f40FD105D980Cbca33A7Ca3fb28992F75";
const contractABI = [
  {
  "constant": true,
  "inputs": [],
  "name": "getWillsCount",
  "outputs": [
      {
          "name": "length",
          "type": "uint256"
      }
  ],
  "payable": false,
  "stateMutability": "view",
  "type": "function"
},
{
  "constant": false,
  "inputs": [
      {
          "name": "willHash",
          "type": "string"
      },
      {
          "name": "personalDetail",
          "type": "string"
      },
      {
          "name": "assetAllocation",
          "type": "string"
      },
      {
          "name": "executorImageIpfsHash",
          "type": "string"
      }
  ],
  "name": "upload",
  "outputs": [
      {
          "name": "",
          "type": "string"
      }
  ],
  "payable": false,
  "stateMutability": "nonpayable",
  "type": "function"
},
{
  "constant": true,
  "inputs": [
      {
          "name": "willHash",
          "type": "string"
      }
  ],
  "name": "getWill",
  "outputs": [
      {
          "name": "",
          "type": "string"
      },
      {
          "name": "",
          "type": "string"
      },
      {
          "name": "",
          "type": "string"
      },
      {
          "name": "",
          "type": "uint256"
      }
  ],
  "payable": false,
  "stateMutability": "view",
  "type": "function"
},
{
  "inputs": [],
  "payable": false,
  "stateMutability": "nonpayable",
  "type": "constructor"
}
];

const Web3 = require("web3");
const web3 = new Web3(window.ethereum);
window.ethereum.enable();     
const contract = new web3.eth.Contract(contractABI, contractAddress);

export default contract;
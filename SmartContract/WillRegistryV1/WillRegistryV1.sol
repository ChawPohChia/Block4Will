pragma solidity ^0.4.18;

contract WillRegistry {
    
    struct Will {
        string willHash;
        string personalDetail;
        string assetAllocation;
        string executorImageIpfsHash;
        uint256 dateAdded;
    }

    Will[] private Wills;
    address contractOwner;

    modifier onlyOwner() {
        require(contractOwner == msg.sender);
        _;
    }

    constructor() public {
        contractOwner = msg.sender;
    }

    function upload(string willHash, string personalDetail, string assetAllocation, string executorImageIpfsHash) public returns (string) {
        uint256 dateAdded = block.timestamp;
        Wills.push(Will(willHash, personalDetail, assetAllocation, executorImageIpfsHash, dateAdded));
        return willHash;
    }

    function getWillsCount() public view returns (uint length) {
        length = Wills.length;
    }
    

    function getWill(string willHash) public view returns (string, string, string, uint256) {
        for (uint i = 0; i < Wills.length; i++) {
            if(bytes(Wills[i].willHash).length != bytes(willHash).length) {
                continue;
            } 
            else if(keccak256(abi.encodePacked(Wills[i].willHash)) == keccak256(abi.encodePacked(willHash))) {
                  return (Wills[i].personalDetail, Wills[i].assetAllocation, Wills[i].executorImageIpfsHash, Wills[i].dateAdded);
            }
           
        }
    }

}

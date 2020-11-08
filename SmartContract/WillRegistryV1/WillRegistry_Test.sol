pragma solidity >=0.4.22 <0.7.0;
import "remix_tests.sol"; 
import "../WillRegistry.sol";


contract WillRegistry_UnitTests{
     WillRegistry artifact;
  
    function beforeAll() public {
        artifact = new WillRegistry();
        artifact.upload("willHash", "personalDetail", "assetAllocation", "executorImageIpfsHash");
    }

    function checkGetWillsCount() public {
        Assert.equal(artifact.getWillsCount(),1, "Total will count should be 1 after initial upload");
    }
    
    function checkGetWill() public {
         //(Wills[i].personalDetail, Wills[i].assetAllocation, Wills[i].executorImageIpfsHash, Wills[i].dateAddedIntoSmartContract)
         string memory personalDetail;
         string memory assetAllocation;
         string memory executorImageIpfsHash;
         uint256 dateAddedIntoSmartContract;
         (personalDetail, assetAllocation, executorImageIpfsHash, dateAddedIntoSmartContract) = artifact.getWill("willHash");
         
         Assert.equal(keccak256(abi.encodePacked(personalDetail)),keccak256(abi.encodePacked("personalDetail")), "Personal details not match to the retrieved will");
         Assert.equal(keccak256(abi.encodePacked(assetAllocation)),keccak256(abi.encodePacked("assetAllocation")), "Asset Allocations not match to the retrieved will");
         Assert.equal(keccak256(abi.encodePacked(executorImageIpfsHash)),keccak256(abi.encodePacked("executorImageIpfsHash")), "Executor Image Ipfs Hash not match to the retrieved will");
    }
}


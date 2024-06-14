// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@thirdweb-dev/contracts/extension/ContractMetadata.sol";


contract TipJar is ContractMetadata{
    address public owner;

    event TipRecieved (address indexed tipper, uint256 amount);
    event TipWithdrawn (address indexed owner, uint256 amount);

    constructor(){
        owner = msg.sender;
    }
    modifier onlyOwner() {
        require(msg.sender== owner, "ONly owner can call this function");
        _;
    }
    function tip() public payable{
        require(msg.value > 0," you must sent a tip" );
        emit TipRecieved(msg.sender, msg.value);

    }
    function Withdraw() public onlyOwner {
        uint256 contractbalance = address(this).balance;
        require(contractbalance  > 0, "there is no tip to withdraw");
        payable(owner).transfer(contractbalance );
        emit TipWithdrawn(owner, contractbalance );
    }
    function getBalance() public view returns(uint256){
        return address(this).balance;
    }
    function _canSetContractURI() internal view virtual override returns (bool){
        return msg.sender == owner;
    }
}
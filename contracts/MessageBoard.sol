// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract MessageBoard {
    address public owner;
    string[] public messages;

    event newMessage ( address indexed sender, string message);

    constructor() {
    owner = msg.sender;

    }
   
   
   
    function sendMessage(string memory message) public {
        messages.push(message);
        emit newMessage(msg.sender, message);

    }
    function getMessagesCount() public view returns(uint256) {
        return messages.length;
    }
    
    function getMessage(uint256 index) public view returns (string memory) {
        require(index < messages.length, "index out of bounds");
        return messages[index];
    }

}
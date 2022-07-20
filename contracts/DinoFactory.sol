//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract DinoFactory is Ownable, ERC721Enumerable{

    event NewDino(uint256 dinoId, string name, uint256 dna);

    string public BaseURI;
    uint256 public cost = 0.008 ether;
    uint256 public maxMintAmount = 5;
    uint256 public maxSupply = 10000;
    // uint256 public totalSupply = 0;
    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;

    constructor(string memory _baseURI) public ERC721("Dino", "DNO") ERC721Enumerable() {
        transferOwnership(msg.sender);
        hgfhfhgfhgfhg
    }

    struct Dino {
        string name;
        uint256 dna;
        uint32 level;
    }

    Dino[] public dinos;

    mapping(uint256 => address) public dinoToOwner;
    mapping(address => uint256) ownerDinoCount;

    function _createDino(string memory _name, uint256 _dna) internal {
        dinos.push(Dino(_name, _dna, 1));
        uint256 dinoId = dinos.length - 1;
        dinoToOwner[dinoId] = msg.sender;
        ownerDinoCount[msg.sender]++;
        // totalSupply++;

        emit NewDino(dinoId, _name, _dna);
    }

    function _generateRandomDna(string memory _string)
        private
        view
        returns (uint256)
    {
        uint256 rand = uint256(keccak256(abi.encodePacked(_string)));
        return rand % dnaModulus;
    }

    function mintRandomDino(string memory _name, uint256 _amount)
        public
        payable
    {
        require(
            _amount <= 5 && _amount > 0,
            "You are allowed to mint ONLY 5 Dinos at a time."
        );
        require(
            ownerDinoCount[msg.sender] <= 5,
            "You are allowed to own ONLY 5 Dinos."
        );
        // require(totalSupply <= maxSupply, "Sold out");
        require(msg.value >= cost, "Not enough payment vlaue");

        uint256 randDna = _generateRandomDna(_name);
        _createDino(_name, randDna);
    }
}

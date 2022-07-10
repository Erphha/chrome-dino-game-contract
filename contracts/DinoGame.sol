//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./DinoFactory.sol";

contract DinoGame is DinoFactory {
    uint256 levelUpScore = 2000;

    modifier aboveLevel(uint256 _level, uint256 _dinoId) {
        dinos[_dinoId].level >= _level;
        _;
    }

    modifier ownerOfDino(uint256 _dinoId) {
        require(msg.sender == dinoToOwner[_dinoId]);
        _;
    }


    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        payable(msg.sender).transfer(balance);
    }

    function levelUp(uint256 _dinoId, uint _score) external {
        require(levelUpScore >= _score);
        dinos[_dinoId].level++;
    }

    function changeName(uint256 _dinoId, string calldata _newName)
        external
        ownerOfDino(_dinoId)
        aboveLevel(10, _dinoId)
    {
        dinos[_dinoId].name = _newName;
    }

    function changeDna(uint256 _NewDna, uint256 _dinoId)
        external
        ownerOfDino(_dinoId)
        aboveLevel(20, _dinoId)
    {
        dinos[_dinoId].dna = _NewDna;
    }

    function getDinosByOwner(address _owner)
        external
        view
        onlyOwner
        returns (uint256[] memory)
    {
        uint256[] memory result = new uint256[](ownerDinoCount[_owner]);

        uint256 counter = 0;
        for (uint256 i = 0; i < dinos.length; i++) {
            if (dinoToOwner[i] == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract SupplyChain is Ownable {

    struct Supplier {
        string name;
        string location;
    }

    struct Item {
        string itemId;
        string description;
        string itemType;
        Supplier supplier;
        Item[] origins;
    }

    mapping(string => Item) public items;

    event ItemCreated(string indexed itemId, string itemType, string supplierName, string description);
    event OriginAdded(string indexed itemId, string originItemId);

    function createItem(
        string memory _itemId,
        string memory _itemType,
        string memory _description,
        string memory _supplierName,
        string memory _supplierLocation
    ) public onlyOwner {
        require(bytes(_itemId).length > 0, "ID do item invalido");
        require(bytes(_itemType).length > 0, "Tipo de item invalido");
        require(bytes(_supplierName).length > 0, "Nome do fornecedor invalido");
        require(bytes(_description).length > 0, "Descricao invalida");

        Item storage item = items[_itemId];
        require(bytes(item.itemId).length == 0, "Item ja existe");

        Supplier memory supplier = Supplier({
            name: _supplierName,
            location: _supplierLocation
        });

        item.itemId = _itemId;
        item.itemType = _itemType;
        item.supplier = supplier;
        item.description = _description;

        emit ItemCreated(_itemId, _itemType, _supplierName, _description);
    }

    function addOrigin(
        string memory _itemId,
        string memory _originItemId
    ) public onlyOwner {
        Item storage item = items[_itemId];
        require(bytes(item.itemId).length > 0, "Item nao encontrado");

        Item storage originItem = items[_originItemId];
        require(bytes(originItem.itemId).length > 0, "Item de origem nao encontrado");

        item.origins.push(originItem);

        emit OriginAdded(_itemId, _originItemId);
    }

    function getOrigins(string memory _itemId) public view returns (Item[] memory) {
        Item storage item = items[_itemId];
        return item.origins;
    }
}
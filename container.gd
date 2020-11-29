extends StaticBody

var test_inventory = {
    "Scrap Metal": {
        "name": "Scrap Metal",
        "count": 1,
        "is_stackable": "false"
    },
    "Ammo": {
        "name": "Ammo",
        "count": 3,
        "is_stackable": "false"
    }
}

var inventory : Inventory

func _ready() -> void:
    inventory = Inventory.new(test_inventory)

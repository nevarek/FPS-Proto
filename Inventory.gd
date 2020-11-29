extends Node
class_name Inventory

var _inventory : Dictionary

func _init(new_inventory : Dictionary = {}) -> void:
    _inventory = new_inventory

func add_item(item : Dictionary):
    if item.has('name') == false:
        print_debug('item has no name?')
        print(item)
        return

    # do we have one already?
    var existing_item = _inventory.get(item.name)
    if existing_item != null and existing_item.is_stackable:
        existing_item.count += item.count
        return

    # add a new entry
    _inventory[item.name] = item

func sorted(field_name : String = '') -> Array:
    return _inventory.values()

func get_count(item_name : String) -> int:
    var count = 0

    var existing_item = _inventory.get(item_name)
    if existing_item != null:
        count = existing_item.count

    return count

func remove(item) -> Dictionary:
    var item_data : Dictionary = {}

    if item is String:
        item_data = _inventory.get(item, {}).duplicate(true)
        _inventory.erase(item)

    if item is Dictionary:
        item_data = _inventory.get(item.name, {}).duplicate(true)
        _inventory.erase(item.name)

    return item_data

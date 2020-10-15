extends Control

var ItemListNode
var container_name : String

func _ready() -> void:
    ItemListNode = $VBoxContainer/InventoryItemList
    hide_inventory()

func hide_inventory() -> void:
    visible = false
    clear()

func show_inventory(container) -> void:
    if visible: return

    $VBoxContainer/Label.text = container.name
    var inventory_list = container.get('inventory')

    for item in inventory_list:
        ItemListNode.add_item(item)

    visible = true

func clear() -> void:
    container_name = '<CONTAINER>'
    ItemListNode.clear()


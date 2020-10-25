extends Control

var ItemListNode
var container_name : String

func _ready() -> void:
    ItemListNode = $VBoxContainer/ScrollContainer/InventoryItemList
    hide_inventory()

func loot_item(player : KinematicBody) -> void:
    ItemListNode.take_item(player)

func open_menu(player : KinematicBody) -> void:
    print('open menu')

func hide_inventory() -> void:
    visible = false
    clear()

func show_inventory(container) -> void:
    if visible: return

    $VBoxContainer/Label.text = container.name
    var inventory_list = container.get('inventory')

    for item in inventory_list:
        ItemListNode.add_item(item)

    _set_hotkey_hints()

    visible = true

func clear() -> void:
    container_name = '<CONTAINER>'
    ItemListNode.clear()

func _set_hotkey_hints() -> void:
    var take_hotkey = OS.get_scancode_string(ProjectSettings.get_setting('input/activate').events[0].get_scancode_with_modifiers())
    var open_menu_hotkey = OS.get_scancode_string(ProjectSettings.get_setting('input/open_menu').events[0].get_scancode_with_modifiers())
    var take_all_hotkey = OS.get_scancode_string(ProjectSettings.get_setting('input/take_all').events[0].get_scancode_with_modifiers())

    $VBoxContainer/HBoxContainer/HintTake.text = '[%s] Take Item' % [take_hotkey]
    $VBoxContainer/HBoxContainer/HintTakeAll.text = '[%s] Take All' % [take_all_hotkey]
    $VBoxContainer/HBoxContainer/HintOpenMenu.text = '[%s] Open Menu' % [open_menu_hotkey]


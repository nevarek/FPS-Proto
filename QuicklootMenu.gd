extends Control

func _ready() -> void:
    visible = false

func show_inventory(inventory_list : Array) -> void:
    if visible == true: return


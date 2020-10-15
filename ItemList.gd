extends VBoxContainer

func clear() -> void:
    for item in get_children():
        item.queue_free()

func add_item(item) -> void:
    var new_item_lbl = Label.new()
    new_item_lbl.text = str(item.name)
    add_child(new_item_lbl)

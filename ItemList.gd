extends VBoxContainer

var selected_index = 0

func _ready() -> void:
    pass

func clear() -> void:
    for item in get_children():
        item.queue_free()

func add_item(item) -> void:
    var new_item_lbl = Label.new()
    new_item_lbl.text = str(item.name)
    add_child(new_item_lbl)

func set_selected_index() -> void:
    if get_child_count() == 0: return

    get_children()[selected_index]

func take_item(player : KinematicBody) -> void:
    print('take')

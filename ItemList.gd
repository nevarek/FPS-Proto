extends VBoxContainer

var selected_index = 0
var _container

func _ready() -> void:
    pass

func clear() -> void:
    for item in get_children():
        item.queue_free()

    _container = null
    selected_index = 0

func add_item(item) -> void:
    var new_item_lbl = Label.new()
    new_item_lbl.align = Label.ALIGN_CENTER
    new_item_lbl.text = str(item.name)
    if item.count > 1:
        new_item_lbl.text += ' (%s)' % str(item.count)
    add_child(new_item_lbl)

func set_selected_index() -> void:
    if get_child_count() == 0: return

    #get_children()[selected_index]

func take_item(player : KinematicBody) -> void:
    if is_container(_container) == false or _container.inventory.sorted().size() == 0:
        return

    var item_index = 0

    if player.is_in_group('players'):
        # get item
        var item = _container.inventory.sorted()[item_index]
        _container.inventory.remove(item)
        remove_child(get_children()[item_index])

        # add item to inventory
        if item == null: return
        player.add_item(item)

func set_container(container : Spatial) -> void:
    if is_container(container) == false:
        return

    _container = container

    for item in _container.inventory.sorted():
        add_item(item)

func is_container(container) -> bool:
    return is_instance_valid(container) and container.is_in_group(Constants.NODE_GROUP_CONTAINERS)

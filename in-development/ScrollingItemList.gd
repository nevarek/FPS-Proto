extends ScrollContainer

var element_height_px = 14
var page_size = 4
var items = []

func _ready() -> void:
    for i in range(10):
        items.append({ name = 'test item 00%s' % i})

    var element_separation = $List.get('custom_constants/separation')
    rect_size.y = page_size * (element_height_px + element_separation)

    for child in $List.get_children():
        $List.remove_child(child)

    for item in items:
        var nl = Label.new()
        nl.text = item.name
        $List.add_child(nl)


func _on_Label_gui_input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
        pass

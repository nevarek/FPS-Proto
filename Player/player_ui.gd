extends Control

var player : KinematicBody

func _ready():
    player = find_parent('Player')
    var buttons = $Menus/GameMenu/PanelContainer/VBoxContainer/Buttons
    buttons.get_node('Quit').connect('pressed', self, '_game_quit')
    buttons.get_node('Resume').connect('pressed', self, 'resume')

    resume()

func _init_player_ui() -> void:
    player.emit_signal('health_changed')

    if is_player_viewing_container() == false:
        $Menus/ContainerQuickview.hide_inventory()
        return

    $Menus/ContainerQuickview.show_inventory(player.looking_at)

    $GameUI/Crosshair/Hovered.visible = is_player_viewing_interactable()


func _input(event: InputEvent) -> void:
    if event.is_action_released('ui_cancel'):
        if is_mouse_captured() == true:
            pause()
        else:
            resume()

    _process_player(event)

func pause() -> void:
    $Menus/GameMenu.visible = true
    Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func resume():
    $Menus/GameMenu.visible = false
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _game_quit() -> void:
    get_tree().quit()

func is_mouse_captured() -> bool:
    return Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED

func is_player_viewing_container() -> bool:
    return player.looking_at != null and player.looking_at.is_in_group('containers')

func is_player_viewing_interactable() -> bool:
    return player.looking_at != null and player.looking_at.is_in_group('interactable')

func _process_container_input(event : InputEvent) -> void:
    if is_player_viewing_container() == false:
        $Menus/ContainerQuickview.hide_inventory()
        return

    $Menus/ContainerQuickview.show_inventory(player.looking_at)

    if event.is_action_released('activate'):
        $Menus/ContainerQuickview.loot_item(player)


func _process_player(event : InputEvent, forced : bool = false) -> void:
    if forced == true or event is InputEventMouseMotion:
        $GameUI/Crosshair/Hovered.visible = is_player_viewing_interactable()

    _process_container_input(event)



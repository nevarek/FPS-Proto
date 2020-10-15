extends Control

var player : KinematicBody

func _ready():
    player = find_parent('Player')
    var buttons = $Menus/GameMenu/PanelContainer/VBoxContainer/Buttons
    buttons.get_node('Quit').connect('pressed', self, '_game_quit')
    buttons.get_node('Resume').connect('pressed', self, 'resume')

    resume()

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

func _process_player(event : InputEvent) -> void:
    if event is InputEventMouseMotion:
        if player.looking_at == null or player.looking_at.is_in_group('containers') == false:
            $Menus/ContainerQuickview.hide_inventory()
            return

        $Menus/ContainerQuickview.show_inventory(player.looking_at)

extends Spatial

signal weapon_changed

onready var player : Node

var weapons = []
var current_weapon : Node

func _ready() -> void:
    weapons = get_children()
    current_weapon = weapons[0]
    current_weapon.show()
    current_weapon.initialize()

func _physics_process(delta: float) -> void:
    if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
        if current_weapon.continuous_fire == false: return
        if Input.is_action_pressed('action_primary'):
            current_weapon.activate()

func _input(event: InputEvent) -> void:
    if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
        if current_weapon.continuous_fire == true: return
        if Input.is_action_just_pressed('action_primary'):
            current_weapon.activate()
        if event.is_action_released('weapon_1'):
            set_weapon(0)
        if event.is_action_released('weapon_2'):
            set_weapon(1)

func set_weapon(index : int) -> void:
    if weapons[index] == current_weapon: return
    current_weapon.hide()
    current_weapon = weapons[index]
    current_weapon.show()
    current_weapon.initialize()

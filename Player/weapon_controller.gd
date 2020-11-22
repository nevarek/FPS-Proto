extends Node

var player : KinematicBody
var current_weapon : Spatial

func _ready() -> void:
    player = find_parent('Player')
    current_weapon = player.get_node('CameraRig/Weapon')

func _input(event: InputEvent) -> void:
    if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED: return

    if event.is_action_pressed('action_primary'):
        var weapon_ref = current_weapon.get_children()[0]

        var camera = player.get_node('CameraRig/Camera')
        var from = camera.project_ray_origin(event.position)
        var to = from + camera.project_ray_normal(event.position) * weapon_ref.ray_length
        weapon_ref.activate(from, to)

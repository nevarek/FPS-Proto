extends Node

var MOUSE_SENSITIVITY = 0.05

var player : KinematicBody
var rotation_helper : Spatial
var UI : Control

func _ready() -> void:
    set_process_input(false)

    player = find_parent('Player')
    rotation_helper = player.get_node('CameraRig')
    UI = player.get_node('UI')

    player.connect('ready_to_play', self, 'init_play')

func init_play() -> void:
    var p = get_viewport().size / 2
    _process_object_under_cursor(p)
    set_process_input(true)

func _input(event: InputEvent) -> void:
    if UI.is_mouse_captured() and event is InputEventMouseMotion:
        _process_camera_movement(event)
        _process_object_under_cursor(event.position)

func _process_camera_movement(event : InputEvent) -> void:
    rotation_helper.rotate_x(deg2rad(-event.relative.y * MOUSE_SENSITIVITY))
    player.rotate_y(deg2rad(-1 * event.relative.x * MOUSE_SENSITIVITY)) # see note [1] to explain formula

    var camera_rotation = rotation_helper.rotation_degrees
    camera_rotation.x = clamp(camera_rotation.x, -90, 90) # limit camera look
    rotation_helper.rotation_degrees = camera_rotation

func _process_object_under_cursor(cursor_position : Vector2) -> void:
    var ray_length = 7
    var camera = player.get_node('CameraRig/Camera')
    var from = camera.project_ray_origin(cursor_position)
    var to = from + camera.project_ray_normal(cursor_position) * ray_length
    var space_state = player.get_world().direct_space_state
    var result = space_state.intersect_ray(from, to, [], 13)
    var body : Spatial = result.get('collider')
    if body == null:
        player.looking_at = null
        return

    player.looking_at = body

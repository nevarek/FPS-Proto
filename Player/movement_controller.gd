extends Node

var player : KinematicBody

var velocity : Vector3
var direction : Vector3

var speed : float = 12.0

func _ready() -> void:
    player = find_parent('Player')

func _physics_process(delta: float) -> void:
    _get_input()
    _process_movement(delta)

# set direction of movement based on input
func _get_input() -> void:
    # by default, forward direction unit vector is (0, 0, -1), aka -z
    # we must use the player's transform basis vectors to point the movement direction
    # relative to what the player is facing
    direction = Vector3.ZERO

    if Input.is_action_pressed('move_forward'):
        direction += -player.global_transform.basis.z
    if Input.is_action_pressed('move_backward'):
        direction += player.global_transform.basis.z
    if Input.is_action_pressed('move_left'):
        direction += -player.global_transform.basis.x
    if Input.is_action_pressed('move_right'):
        direction += player.global_transform.basis.x

    direction = direction.normalized()

# make the player move
func _process_movement(delta : float) -> void:
    velocity = speed * direction

    if velocity.length() > 5:
        player.move_and_slide(velocity, Vector3.UP)

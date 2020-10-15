extends KinematicBody

var GRAVITY : float = -55.8
var MAX_SPEED : float = 30.0
var JUMP_SPEED : float = 35.0
var ACCELERATION : float = 10.5
var DEACCELERATION : float = 26.0
var MAX_SLOPE_ANGLE : float = 40.0

# movement
var direction : Vector3
var velocity : Vector3

# Camera
var camera : Camera
var rotation_helper : Spatial
var MOUSE_SENSITIVITY : float = 0.05
var mouse_scroll_value = 0
const MOUSE_SENSITIVITY_SCROLL_WHEEL = 0.08

func _ready():
    camera = $Rotation_Helper/Camera
    rotation_helper = $Rotation_Helper

    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
    velocity = Vector3()

# process dependencies in some order
func _physics_process(delta : float):
    _process_input(delta)
    _process_movement(delta)
    _process_UI(delta)
    #_process_animation(delta)

func _process_input(delta : float):
    direction = Vector3()

    var cam_xform := camera.get_global_transform()

    var input_movement_vector := Vector2()

    if Input.is_action_pressed('movement_forward'):
        input_movement_vector.y += 1
    if Input.is_action_pressed('movement_backward'):
        input_movement_vector.y -= 1
    if Input.is_action_pressed('movement_left'):
        input_movement_vector.x -= 1
    if Input.is_action_pressed('movement_right'):
        input_movement_vector.x += 1

    input_movement_vector = input_movement_vector.normalized()

    # Remember: input_movement_vector is a Vector2, so in 3d space: x = x and y = z
    direction += -cam_xform.basis.z * input_movement_vector.y
    direction += cam_xform.basis.x * input_movement_vector.x

    # JUMPIN'
    if is_on_floor():
        if Input.is_action_just_pressed('movement_jump'):
            velocity.y = JUMP_SPEED

    # Mouse capture toggle
    if Input.is_action_just_released('ui_cancel'):
        if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
            Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
        else:
            Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

        $HUD._toggle_pause()

    if Input.is_action_just_released('ui_toggle_ui'):
        $HUD/GameUI.visible = !$HUD/GameUI.visible

    if Input.is_action_just_released('action_primary'):
        $Rotation_Helper/Camera/AnteriorGizmo/Melee.activate()
    if Input.is_action_just_released('action_secondary'):
        $Rotation_Helper/Camera/AnteriorGizmo/HitScan.activate()
    if Input.is_action_just_pressed('action_projectile'):
        $Rotation_Helper/Camera/AnteriorGizmo/Projectile.activate()


func _process_movement(delta : float):
    # remove y-movement from direction (for now)
    direction.y = 0
    direction = direction.normalized()

    # apply gravity to current velocity
    velocity.y += delta * GRAVITY

    # remove y-movement from velocity (for now)
    var horizontal_velocity = velocity
    horizontal_velocity.y = 0

    # determine largest move toward direction
    var max_displacement = direction
    max_displacement *= MAX_SPEED

    # set acceleration value
    var accel
    if direction.dot(velocity) > 0:
        accel = ACCELERATION
    else:
        accel = DEACCELERATION

    # move toward the max speed based time and acceleration
    horizontal_velocity = horizontal_velocity.linear_interpolate(max_displacement, accel * delta)
    velocity.x = horizontal_velocity.x
    velocity.z = horizontal_velocity.z
    velocity = move_and_slide(velocity, Vector3.UP, false, 4, deg2rad(MAX_SLOPE_ANGLE)) # uses delta automatically

func _input(event):
    if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
        rotation_helper.rotate_x(deg2rad(event.relative.y * MOUSE_SENSITIVITY))
        self.rotate_y(deg2rad(-1 * event.relative.x * MOUSE_SENSITIVITY)) # see note [1] to explain formula

        var camera_rotation = rotation_helper.rotation_degrees
        camera_rotation.x = clamp(camera_rotation.x, -70, 70) # limit camera look
        rotation_helper.rotation_degrees = camera_rotation

    if event is InputEventMouseButton and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
        pass

# Process Control node UI here
func _process_UI(delta : float):
    pass

# Process this 3D model (animations, textures, etc.)
func _process_model(delta : float):
    pass


# NOTES
# [1]
# Godot converts relative mouse motion into a Vector2 where mouse movement going up and down is 1 and -1 respectively. Right and Left movement is 1 and -1 respectively.
# Because of how we are rotating the player, we multiply the relative mouse motion's X value by -1 so mouse motion going left and right rotates the player left and right in the same direction.
#

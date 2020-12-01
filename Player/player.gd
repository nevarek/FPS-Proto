extends Spatial

signal weapon_changed
signal health_changed
signal ready_to_play

var camera : Camera
var UI : Control
var controllers : Node

var stats = {
    strength = 1,
    perception = 1,
    endurance = 1,
    charisma = 1,
    intelligence = 1,
    agility = 1,
    luck = 1
}

var skills = {
    sneak = 0
}

var action_points = Vector2(5, 5) setget _set_ap
var health : Vector2 = Vector2(70, 100) setget _set_health
var looking_at : Spatial

var inventory : Inventory
var weapon_controller : Node

func _set_ap(value) -> void:
    action_points[0] = min(value, action_points[1])

func _set_health(value) -> void:
    health[0] = min(value[0], health[1])
    emit_signal('health_changed')

func _ready() -> void:
    camera = $CameraRig/Camera
    UI = $UI
    controllers = $Controllers
    weapon_controller = $CameraRig/WeaponController

    emit_signal('ready_to_play')
    init_ui()
    inventory = Inventory.new()

func init_stats() -> void:
    action_points[1] = 5 + stats.agility / 2
    action_points[0] = action_points[1]

func init_ui() -> void:
    $UI._init_player_ui()

func hit(projectile) -> void:
    if projectile and projectile.get('damage'):
        health -= projectile.damage

        emit_signal('health_changed')

        if health[0] <= 0:
            die()

func die() -> void:
    get_tree().quit()

func _physics_process(delta: float) -> void:
    pass

func add_item(item) -> void:
    var existing_item = inventory.get(item.name)
    if existing_item != null and existing_item.is_stackable:
        existing_item.count += 1

func get_hud() -> Node:
    return $UI/GameUI/GeneralHUD

func get_weapon() -> Node:
    return $CameraRig/WeaponController.current_weapon

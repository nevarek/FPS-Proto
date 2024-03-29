extends Spatial
class_name Weapon

signal ammo_changed

export (PackedScene) var projectile_scene = preload('res://Bullet.tscn')
export (PackedScene) var muzzle_flash = preload('res://Pistol_MuzzleFlash.tscn')

export (int) var damage = 10
export (int) var magazine_size_max = 10
export (int) var projectile_speed = 200
export (int) var projectile_range = 1000
export (float) var fire_rate = 0.3
export (bool) var continuous_fire = false

export (bool) var infinite_ammo = false
export (int) var current_ammo : int setget , get_current_ammo
var remaining_ammo : int setget , get_remaining_ammo

var player : KinematicBody

func _enter_tree() -> void:
    player = find_parent('Player')

func _ready() -> void:
    $FiringRateTimer.wait_time = fire_rate
    current_ammo = magazine_size_max

func get_remaining_ammo() -> int:
    if not is_instance_valid(player) or not is_instance_valid(player.inventory):
        return 0
    return player.inventory.get_count('Ammo')

func get_current_ammo() -> int:
    return current_ammo

func hide() -> void:
    visible = false

func show() -> void:
    visible = true

func initialize() -> void:
    debug.printd('init %s' % name)
    player.get_hud().set_weapon(self)

func activate() -> void:
    if _can_fire():
        shoot_bullet()
        play_shoot_animations()
        if infinite_ammo == false:
            current_ammo -= 1
        $FiringRateTimer.start()
        emit_signal('ammo_changed')

func play_shoot_animations():
    var new_mf = muzzle_flash.instance()
    $FiringPoint.add_child(new_mf)
    new_mf.play()

func shoot_ray() -> void:
    var screen_midpoint = get_viewport().size / 2
    var camera = player.get_node('CameraRig/Camera')
    var from = camera.project_ray_origin(screen_midpoint)
    var to = from + camera.project_ray_normal(screen_midpoint) * projectile_range

    var space_state = get_world().direct_space_state
    var result = space_state.intersect_ray(from, to, [], 13)

    # get the collided body and do callback if possible
    var body = result.get('collider')
    if body == null: return
    if body.has_method('object_hit') == false: return

    if result.get('position') == null:
        print_debug('no collision position for collider...?')

    body.object_hit(damage, result)

func shoot_bullet() -> void:
    # create a bullet
    var projectile_instance : Spatial = projectile_scene.instance()
    var scene_root = get_tree().root.get_children()[0]
    scene_root.add_child(projectile_instance)

    # set up bullet
    projectile_instance.global_transform = $FiringPoint.global_transform
    projectile_instance.scale = Vector3(1, 1, 1)
    projectile_instance.PROJECTILE_DAMAGE = damage
    projectile_instance.PROJECTILE_SPEED = projectile_speed

func _can_fire() -> bool:
    return $FiringRateTimer.is_stopped() and current_ammo > 0

func reload() -> void:
    debug.printd('reloading %s' % name)
    current_ammo = magazine_size_max
    emit_signal('ammo_changed')

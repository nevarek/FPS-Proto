extends Spatial

var projectile_scene = preload('res://Bullet.tscn')
var muzzle_flash = preload('res://Pistol_MuzzleFlash.tscn')

onready var player : KinematicBody = find_parent('Player')

var damage = 10
var magazine_ammo = 10
var max_ammo = 30
var projectile_speed = 200
var ray_length = 1000

func activate(from, to) -> void:
    shoot_ray(from, to)
    play_shoot_animations()

func play_shoot_animations():
    var new_mf = muzzle_flash.instance()
    $FiringPoint.add_child(new_mf)
    new_mf.play()

func shoot_ray(from, to) -> void:
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

extends Spatial

var projectile_scene : PackedScene = preload('Projectile.tscn')

const CAN_RELOAD = true
const CAN_REFILL = true

const IDLE_ANIM_NAME = 'projectile_idle'
const FIRE_ANIM_NAME = 'projectile_fire'
const RELOADING_ANIM_NAME = 'projectile_reload'

var damage : float = 15.0
var projectile_speed : float = 50.0

func _ready():
    pass

func activate() -> void:
    # create a bullet
    var projectile_instance : Spatial = projectile_scene.instance()
    var scene_root = get_tree().root.get_children()[0]
    scene_root.add_child(projectile_instance)

    # set up bullet
    projectile_instance.global_transform = self.global_transform
    projectile_instance.scale = Vector3(2, 2, 2)
    projectile_instance.PROJECTILE_DAMAGE = damage
    projectile_instance.PROJECTILE_SPEED = projectile_speed

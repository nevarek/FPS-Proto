extends Spatial

const CAN_RELOAD = true
const CAN_REFILL = true

const IDLE_ANIM_NAME = 'Hitscan_idle'
const FIRE_ANIM_NAME = 'Hitscan_fire'
const RELOADING_ANIM_NAME = 'Hitscan_reload'

var damage : float = 4.0
var player_node : KinematicBody

func _ready():
    pass

func activate():
    var ray = $Ray_Cast
    ray.force_raycast_update()
    DrawLine3D.DisplayRay(ray, Color(0, 0, 1))

    if ray.is_colliding():
        var body : Spatial = ray.get_collider()

        if body == player_node:
            pass
        elif body.has_method('object_hit'):
            body.object_hit(damage, ray.global_transform)

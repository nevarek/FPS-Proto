extends Spatial

const CAN_RELOAD = false
const CAN_REFILL = false

const IDLE_ANIM_NAME = 'melee_idle'
const FIRE_ANIM_NAME = 'melee_fire'
const RELOADING_ANIM_NAME = ''

var damage : float = 40.0
var is_weapon_enabled : bool = false
var player_node : KinematicBody


func _ready():
    pass

func activate():
    var area = $Area
    var collided_bodies : Array = area.get_overlapping_bodies()

    for body in collided_bodies:
        if body == player_node:
            continue

        if body.has_method('object_hit'):
            body.object_hit(damage, area.global_transform)

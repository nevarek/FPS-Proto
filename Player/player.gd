extends Spatial

signal health_changed

var camera : Camera
var UI : Control
var controllers : Node

var health : int = 100
var looking_at : Spatial

var buffs = []
var debuffs = []

func _ready() -> void:
    camera = $CameraRig/Camera
    UI = $UI
    controllers = $Controllers

    looking_at = null

    emit_signal('health_changed')

func hit(projectile) -> void:
    if projectile and projectile.get('damage'):
        health -= projectile.damage

        emit_signal('health_changed')

        if health <= 0:
            die()

func die() -> void:
    get_tree().quit()

func apply_debuff(debuff_info) -> bool:
    var is_immune = false # TODO immunities?

    if is_immune:
        return false

    debuffs.append(debuff_info)
    return true

func _physics_process(delta: float) -> void:
    pass

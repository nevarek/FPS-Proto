extends Spatial

signal health_changed
signal ready_to_play

var camera : Camera
var UI : Control
var controllers : Node

var health : int = 100
var looking_at : Spatial

var inventory = []

func _ready() -> void:
    camera = $CameraRig/Camera
    UI = $UI
    controllers = $Controllers

    emit_signal('ready_to_play')
    init_ui()

func init_ui() -> void:
    $UI._init_player_ui()

func hit(projectile) -> void:
    if projectile and projectile.get('damage'):
        health -= projectile.damage

        emit_signal('health_changed')

        if health <= 0:
            die()

func die() -> void:
    get_tree().quit()

func _physics_process(delta: float) -> void:
    pass

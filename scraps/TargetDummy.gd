extends RigidBody

enum STATES {
    DEAD = 0,
    ALIVE = 1
}

signal spawned
signal hit(collider_location)
signal damaged(damage)
signal killed

var health : int = 100
var _state = STATES.ALIVE

func _ready():
    connect('spawned', self, '_on_spawned')
    connect('hit', self, '_on_hit')
    connect('damaged', self, '_on_damaged')
    connect('killed', self, '_on_killed')

    emit_signal('spawned')

func object_hit(damage : int, collider_location : Transform):
    emit_signal('hit', collider_location)
    emit_signal('damaged', damage)

func _on_spawned():
    mode = RigidBody.MODE_STATIC
    #$AnimationPlayer.play('idle')

func _on_hit(collider_location : Transform):
    if _state != STATES.DEAD:
        var tween = $Tween
        tween.interpolate_property($MeshInstance.mesh.surface_get_material(0), 'albedo_color', ColorN('red'), ColorN('white'), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
        tween.start()

func _on_damaged(amount : int):
    health -= amount
    health = max(0, health)

    if health == 0:
        emit_signal('killed')

func _on_killed():
    _state = STATES.DEAD
    #$AnimationPlayer.play('death')
   # yield($AnimationPlayer, 'animation_finished')
    #$AnimationPlayer.stop()
    #$AnimationPlayer.playback_active = false
    mode = RigidBody.MODE_RIGID


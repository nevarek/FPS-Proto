extends Spatial

signal projectile_stopped(location)

const PROJECTILE_LIFESPAN : float = 4.0
var current_travel_time : float = 0.0

var PROJECTILE_SPEED : float = 70.0
var PROJECTILE_DAMAGE : float = 15.0

var hit_something : bool = false

func _ready():
    $Area.connect('body_entered', self, '_on_collided')
    connect('projectile_stopped', self, '_on_projectile_stopped')

func _on_collided(body):
    if hit_something == false:
        if body.has_method('object_hit'):
            body.object_hit(PROJECTILE_DAMAGE, global_transform)

    hit_something = true # stop projectile
    emit_signal('projectile_stopped', global_transform, hit_something)

func _physics_process(delta):
    var forward_direction = global_transform.basis.z.normalized()
    global_translate(forward_direction * PROJECTILE_SPEED * delta)


    current_travel_time += delta
    if current_travel_time >= PROJECTILE_LIFESPAN:
        emit_signal('projectile_stopped', global_transform)

# @VIRTUAL
# Default behavior is to remove the projectile.
# A reason to override this is if you want to do something when the projectile is removed.
# Impact lets you know if the projectile had a collision instead of running out of lifespan.
func _on_projectile_stopped(location : Transform, impact : bool = false) -> void:
    queue_free()



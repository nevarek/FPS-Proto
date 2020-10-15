extends RigidBody

var BASE_IMPULSE_BOOST = 9

func _ready():
    pass

func object_hit(impulse_multiplier : float, collider_global_transform : Transform):
    var direction_vector = collider_global_transform.basis.z.normalized() * BASE_IMPULSE_BOOST

    var impulse_location = (collider_global_transform.origin - self.global_transform.origin).normalized()
    apply_impulse(impulse_location, direction_vector * impulse_multiplier)

extends StaticBody

var BulletHitScene = preload('res://BulletHit.tscn')

var health = 20

func object_hit(damage : int, collision_info) -> void:
    health -= damage

    play_hit_animation(collision_info)

    if health <= 0:
        destroy()

func destroy() -> void:
    queue_free()

func play_hit_animation(collision_info) -> void:
    var new_hit = BulletHitScene.instance()

    get_parent().add_child(new_hit)
    new_hit.global_transform.origin = collision_info.position
    new_hit.set_direction(collision_info.normal)
    new_hit.play()

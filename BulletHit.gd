extends Particles

func set_direction(normal : Vector3) -> void:
    normal = normal.normalized()

    process_material.set('direction', normal)

func play():
    one_shot = true
    emitting = true


    yield(get_tree().create_timer(lifetime), 'timeout')

    queue_free()

extends MeshInstance

var lifetime = 0.12

func play():
    yield(get_tree().create_timer(lifetime), 'timeout')
    queue_free()

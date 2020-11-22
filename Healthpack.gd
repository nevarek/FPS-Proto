extends Area

var heal_amount = 20

func _on_Healthpack_body_entered(body: Node) -> void:
    if body.is_in_group('players'):
        body.health[0] = min(body.health[0] + heal_amount, body.health[1])
        queue_free()



extends Control

var player : KinematicBody

func _ready() -> void:
    player = find_parent('Player')

    player.connect('health_changed', self, '_on_health_changed')

func _on_health_changed() -> void:
    $HealthDisplay/Value.text = str(player.health)

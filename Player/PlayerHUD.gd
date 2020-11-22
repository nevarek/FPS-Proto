extends Control

var player : KinematicBody

func _ready() -> void:
    player = find_parent('Player')

    player.connect('health_changed', self, '_on_health_changed')

    $Messages.visible = false
    $EnemyInfo.visible = false
    $WeaponInfo.visible = false
    $QuicklootMenu.visible = false

    $PlayerInfo/Health.max_value = player.health[1]

func _on_health_changed() -> void:
    $PlayerInfo/Health.value = player.health[0]

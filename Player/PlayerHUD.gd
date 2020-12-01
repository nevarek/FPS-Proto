extends Control

var player : KinematicBody

func _ready() -> void:
    $Messages.visible = false
    $EnemyInfo.visible = false
    #$WeaponInfo.visible = false
    $QuicklootMenu.visible = false

    player = find_parent('Player')
    if is_instance_valid(player):
        player.connect('health_changed', self, '_on_health_changed')
        player.connect('weapon_changed', self, '_on_weapon_changed')
        $PlayerInfo/Health.max_value = player.health[1]
    else:
        print_debug('warning: no player found')

func _on_health_changed() -> void:
    $PlayerInfo/Health.value = player.health[0]

func set_weapon(weapon : Weapon) -> void:
    if not weapon.is_connected('ammo_changed', self, '_on_ammo_changed'):
        weapon.connect('ammo_changed', self, '_on_ammo_changed')

    _on_ammo_changed()

func _on_ammo_changed() -> void:
    if not is_instance_valid(player):
        breakpoint
        debug.printd('cannot find player instance')
        return
    $WeaponInfo/CurrentAmmo.text = str(player.get_weapon().get_current_ammo())
    $WeaponInfo/RemainingAmmo.text = str(player.get_weapon().get_remaining_ammo())

func _on_weapon_changed() -> void:
    $WeaponInfo.visible = true
    _on_ammo_changed()

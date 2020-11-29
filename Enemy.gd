extends RigidBody

var health := Vector2(5, 5)
var is_dead = false
var object_name = 'Enemy'
var inventory : Inventory

func get_name() -> String:
    return object_name

func _ready() -> void:
    inventory = Inventory.new()

func object_hit(amount, collision_info) -> void:
    if is_dead: return
    health[0] -= 1

    if health[0] <= 0:
        die()

func die() -> void:
    is_dead = true
    rotate_x(deg2rad(-90))
    mode = MODE_RIGID

    roll_drops()
    add_to_group(Constants.NODE_GROUP_CONTAINERS)

func roll_drops() -> void:
    var item = {
        "name": "Ammo",
        "count": 3,
        "is_stackable": "false"
    }
    inventory.add_item(item)

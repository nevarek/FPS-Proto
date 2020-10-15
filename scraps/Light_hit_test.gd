extends StaticBody

func _ready():
    pass

func object_hit(damage : float, collider_global_transform : Transform):
    var light = get_parent()

    light.light_energy = 0
    light.get_node('MeshInstance').get_surface_material(0).albedo_color = ColorN('black')

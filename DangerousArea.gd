extends Spatial

signal finished

var damage_per_tick = 5
var tick_time = 0.2
var total_ticks = 2
var ticks_left

var origin_reference : Spatial = null
var target_reference : Spatial = null

func _init(origin, target) -> void:
    origin_reference = origin
    target_reference = target

    if target_reference == null:
        emit_signal('finished')

    $Area.connect('body_entered', self, '_on_Area_body_entered')

func _ready() -> void:
    ticks_left = total_ticks

func length() -> float:
    return tick_time * total_ticks

func _on_Area_body_entered(body: Node) -> void:
    print(body)

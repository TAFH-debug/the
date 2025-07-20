extends CanvasLayer

@onready var player: CharacterBody3D = get_parent()
@onready var debug_metrics: Label = $DebugMetrics

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var fps: float = Engine.get_frames_per_second()
	var speed: float = snapped(sqrt(player.get_real_velocity().x**2 +player.get_real_velocity().z**2), 0.01)
	debug_metrics.text = "FPS: {0}\nSpeed: {1}".format([fps, speed])

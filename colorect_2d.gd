extends ColorRect

var speed = 300

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	position.x -= speed * delta
	
	if position.x < -100:
		queue_free()

func get_position_and_size():
	return {"pos": position, "size": size}

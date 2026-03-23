extends ColorRect

var speed = 300
var is_moving = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Listen for game_ended signal from GameManager
	var game_manager = get_parent().get_node("GameManager")
	game_manager.game_ended.connect(stop)



func _process(delta: float) -> void:
	if not is_moving:
		return  # Stop moving if game ended
		
	position.x -= speed * delta
	
	if position.x < -100:
		queue_free()

func get_position_and_size():
	return {"pos": position, "size": size}
	
func stop():
	is_moving = false

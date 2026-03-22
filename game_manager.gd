extends Node

var spawn_timer = 0
var spawn_interval = 1.5  # Spawn obstacle every 1.5 seconds
var score = 0
var score_label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_label = get_node("../CanvasLayer/Label")

func _process(delta: float) -> void:
	# Increment score (distance = time survived)
	score += int(delta * 100)
	score_label.text = "Score: " + str(score)
	print("Score: ", score)
	
	# Spawn obstacles
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_obstacle()
		spawn_timer = 0

func spawn_obstacle():
	# Create a new ColorRect
	var obstacle = ColorRect.new()
	obstacle.size = Vector2(50, 100)
	obstacle.position = Vector2(1200, 400)  # Start off-screen right
	obstacle.color = Color.RED
	
	# Load and attach the obstacle script
	var script = load("res://colorect_2d.gd")
	obstacle.set_script(script)
	
	get_parent().add_child(obstacle)

extends Node

var spawn_timer = 0
var spawn_interval = 1.5  # Spawn obstacle every 1.5 seconds
var score = 0
var score_label
var game_state = "menu"  # States: "menu", "playing", "game_over"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_label = get_node("../CanvasLayer/Label")
	update_ui()

func _process(delta: float) -> void:
	if game_state == "menu":
		if Input.is_action_just_pressed("ui_accept"):  # Spacebar
			game_state = "playing"
			update_ui()
			
	elif game_state == "playing":
		# Increment score (distance = time survived)
		score += int(delta * 100)
		score_label.text = "Score: " + str(score)
	
		# Spawn obstacles
		spawn_timer += delta
		if spawn_timer >= spawn_interval:
			spawn_obstacle()
			spawn_timer = 0
			
	elif game_state == "game_over":
		if Input.is_action_just_pressed("ui_accept"):  # Spacebar
			get_tree().reload_current_scene()
			
func update_ui():
	if game_state == "menu":
		score_label.text = "Press SPACE to Start"
	elif game_state == "game_over":
		score_label.text = "GAME OVER!\nPress SPACE to Restart"

func game_over():
	game_state = "game_over"
	update_ui()
	
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
	

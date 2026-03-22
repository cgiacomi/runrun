extends Sprite2D

var velocity = Vector2.ZERO
var gravity = 800
var is_on_ground = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Check if on ground
	is_on_ground = position.y >= 430  # Ground is at y=500, sprite is ~70 pixels tall
	
	# Gravity
	velocity.y += gravity * delta
	
	# Stop at ground
	if is_on_ground and velocity.y > 0:
		velocity.y = 0
		position.y = 430
	
	# Input
	if Input.is_action_pressed("ui_right"):
		velocity.x = 200
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -200
	else:
		velocity.x = 0
	
	# Jumping (only if on ground)
	if Input.is_action_just_pressed("ui_accept") and is_on_ground:
		velocity.y = -400
	
	# Check collision with all spawned obstacles
	var parent = get_parent()
	for child in parent.get_children():
		if child is ColorRect and child.name.contains("ColorRect"):
			var obstacle_rect = Rect2(child.position, child.size)
			var player_rect = Rect2(position.x - 16, position.y - 16, 32, 32)
		
			if player_rect.intersects(obstacle_rect):
				print("GAME OVER!")
				get_node("../GameManager").game_over()
		
		
	# Apply velocity
	position += velocity * delta

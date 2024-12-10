extends Camera2D

#Kamera hrace

@export var speed:int = 100

func _process(delta: float) -> void:
	if Input.is_action_pressed("up"):
		global_position.y -= speed * delta / zoom.x
	if Input.is_action_pressed("down"):
		global_position.y += speed * delta / zoom.x
	if Input.is_action_pressed("left"):
		global_position.x -= speed * delta / zoom.x
	if Input.is_action_pressed("right"):
		global_position.x += speed * delta / zoom.x
	
	if Input.is_action_pressed("zoom_closer"):
		zoom.x += 0.7 * delta
		zoom.y += 0.7 * delta
	if Input.is_action_pressed("zoom_out"):
		zoom.x -= 0.7 * delta
		zoom.y -= 0.7 * delta

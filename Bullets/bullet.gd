extends Area2D

@export var speed: float = 500
func _physics_process(delta):
	global_position.y -= speed * delta 
	
	
	

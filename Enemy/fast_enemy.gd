extends Enemy

@export var rotationRate := 20


func _process(delta):
	rotate(deg_to_rad((rotationRate) * delta))
	if playerInArea != null:
		playerInArea.damage(1)
		
func _physics_process(delta):
	position.y += verticalSpeed * delta


func damage(amount: int):
	health -= amount
	if health <= 0:
		queue_free()
	
	
func _on_area_entered(area):
	if area is Player:
		playerInArea = area


func _on_area_exited(area):
	if area is Player:
		playerInArea = null


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()



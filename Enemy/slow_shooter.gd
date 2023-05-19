extends Area2D

var plBullet := preload("res://Bullets/enemy_bullet.tscn")
@onready var fireTimer := $FireTimer
@onready var firingPositions := $FiringPositions
@export var verticalSpeed := 10.0
@export var health: int = 5
@export var FireRate :=3.0
@export var horizontalSpeed := 50.0
var horizontalDirection: int = 1 
var playerInArea: Player = null


func fire():
	for child in firingPositions.get_children():
			var bullet = plBullet.instantiate()
			bullet.global_position = child.global_position
			get_tree().current_scene.add_child(bullet)

func _process(delta):
	if playerInArea != null:
		playerInArea.damage(1)
		
	if fireTimer.is_stopped():
		fire()
		fireTimer.start(FireRate)


func _physics_process(delta):
	position.y += verticalSpeed * delta
	position.x += horizontalSpeed * delta * horizontalDirection
	
	var viewRect := get_viewport_rect()
	if position.x < viewRect.position.x or position.x > viewRect.end.x:
		horizontalDirection *= -1


func damage(amount: int):
	health -= amount
	if health <= 0:
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
	
func _on_area_entered(area):
	if area is Player:
		playerInArea = area


func _on_area_exited(area):
	if area is Player:
		playerInArea = null

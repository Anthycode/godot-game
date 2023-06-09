extends Area2D


class_name  Player #for put the player into a class
var plBullet := preload("res://Bullets/bullet.tscn")

@onready var animatedSprite := $AnimatedSprite2D
@onready var firingPositions := $FiringPositions
@onready var fireDelayTimer := $FireDelayTimer
@onready var invincibilityTimer := $invincibilitytimer
@onready var shieldSprit := $Shield

@export var isPlayerAliveeee = 1

@export var speed: float = 100
@export var fireDelay: float = 0.1
@export var life: int = 3
@export var damageInvincibilityTimer := 1

var vel := Vector2(0, 0) #vel for velocity
func _ready():
	shieldSprit.visible = false
	Signals.emit_signal("on_player_life_changed", life)
func _process(delta):
	#Animate
	if vel.x == 0:
		animatedSprite.play("straight")
	elif vel.x > 0:
		animatedSprite.play("right")
	else:
		animatedSprite.play("left")
	#check if we are shooting
	if Input.is_action_just_pressed("shoot") and fireDelayTimer.is_stopped():
		fireDelayTimer.start(fireDelay)
		for child in firingPositions.get_children():
			var bullet = plBullet.instantiate()
			bullet.global_position = child.global_position
			get_tree().current_scene.add_child(bullet)


func _physics_process(delta):
	var dirVec := Vector2(0,0)
	
	if Input.is_action_pressed("move_left"):
		dirVec.x = -1
	elif Input.is_action_pressed("move_right"):
		dirVec.x = 1
	if Input.is_action_pressed("move_up"):
		dirVec.y = -1
	elif Input.is_action_pressed("move_down"):
		dirVec.y = 1
	
	vel = dirVec.normalized() * speed # a normalized vector always has a leng of the speed with pythagore
	position += vel * delta

	#Make sur that the player is in the screen 
	var viewRect := get_viewport_rect() # get the size of the screen
	position.x = clamp(position.x, 0, viewRect.size.x)  #Clamps the value, returning a Variant not less than min and not more than max.
	position.y = clamp(position.y, 0, viewRect.size.y)

func damage(amount: int):
	if !invincibilityTimer.is_stopped():
		return
	
	invincibilityTimer.start(damageInvincibilityTimer)
	shieldSprit.visible = true            #shield going to be visible
	
	life -= amount
	Signals.emit_signal("on_player_life_changed", life)
	
	if life <= 0:
		print("Player Died")
		print(isPlayerAliveeee)
		isPlayerAliveeee=0
		print(isPlayerAliveeee)
		queue_free()


func _on_invincibilitytimer_timeout():
	shieldSprit.visible = false


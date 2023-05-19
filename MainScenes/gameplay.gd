extends Node

@export var enemy_scenes: Array[PackedScene] = []
@onready var timer = $EnemySpawnTimer
@onready var enemy_container = $EnemyContainer


func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _on_enemy_spawn_timer_timeout():
	var e = enemy_scenes.pick_random().instantiate()
	e.global_position = Vector2(20, 50)
	enemy_container.add_child(e)
	

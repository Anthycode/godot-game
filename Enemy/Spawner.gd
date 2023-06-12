extends Node2D

var preloadedEnemies := [
	preload("res://Enemy/fast_enemy.tscn"),
	preload("res://Enemy/slow_shooter.tscn")
	]

@onready var spawnTimer := $SpawnTimer

var nextSpawnTime := 5.0

func _ready():
	randomize()
	spawnTimer.start(nextSpawnTime)

func _on_spawn_timer_timeout():
	#spawn enemy
	var enemyPreload = preloadedEnemies[randi() % preloadedEnemies.size()]
	var enemy: Enemy = enemyPreload.instance()
	enemy.position = Vector2(0, position.y)
	get_tree().current_scene.add_child(enemy)
	
	
	#restart timer
	spawnTimer.start(nextSpawnTime)

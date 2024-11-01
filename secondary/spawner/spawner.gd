class_name Spawner extends Node2D

const SPAWN_COUNT_MIN := 1
const SPAWN_COUNT_MAX := 5

const SPAWN_DELAY_MIN := 5.0
const SPAWN_DELAY_MAX := 10.0

const ENEMY := preload("res://secondary/enemy/enemy.tscn")

@export var enable: bool = true
@export var player: Player

@onready var delay: Timer = $Delay

func _ready() -> void:
	_rand_delay_time()

func _rand_delay_time() -> void:
	if not delay.is_stopped():
		delay.stop()
	delay.wait_time = randf_range(SPAWN_DELAY_MIN, SPAWN_DELAY_MAX)
	delay.start()

# Привяжите сигнал "timeout" у "Delay"
func _on_delay_timeout() -> void:
	if is_instance_valid(player) and enable:
		if not delay.is_stopped():
			delay.stop()
		var rand_count := randi_range(SPAWN_COUNT_MIN, SPAWN_COUNT_MAX)
		for i: int in range(rand_count):
			var enemy := ENEMY.instantiate()
			var rand_position := Vector2(randf_range(-10, 10), randf_range(-10, 10))
			enemy.player = player
			enemy.global_position = global_position + rand_position
			get_parent().add_child(enemy)
		_rand_delay_time()

class_name GameManager extends Node2D

@export var player: Player

var game_over: bool

func _ready() -> void:
	var timer: GameTimer = get_tree().get_first_node_in_group("GameTimer")
	if timer:
		timer.timeout.connect(_on_timeout)
	else:
		push_error("Таймера нет на сцене!")
	
	if not is_instance_valid(player):
		player = get_tree().get_first_node_in_group("Player")
		if not player:
			push_error("Игрока нет на сцене!")
	
	var spawners := get_tree().get_nodes_in_group("Spawner")
	for spawner: Spawner in spawners:
		spawner.player = player

func _process(_delta: float) -> void:
	if game_over:
		var enemies := get_tree().get_nodes_in_group("Enemy")
		if enemies.size() > 0:
			for enemy: Enemy in enemies:
				enemy.queue_free()

func _on_timeout() -> void:
	game_over = true
	var spawners := get_tree().get_nodes_in_group("Spawner")
	for spawner: Spawner in spawners:
		spawner.enable = false

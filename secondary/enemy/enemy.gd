class_name Enemy extends Area2D

const SPEED_MULTIPLIER_MIN := 1.0
const SPEED_MULTIPLIER_MAX := 2.5

const HEALTH_MIN := 1
const HEALTH_MAX := 5

# Делаем её публичной на уровне редактора,
# чтобы было удобно на начальном этапе цеплять игрока
@export var player: Player
var is_touches_player: bool

var speed := 100.0
var speed_multiplier: float

var damage := 1

var health: int

@onready var damage_delay: Timer = $DamageDelay

func _ready() -> void:
	speed_multiplier = randf_range(SPEED_MULTIPLIER_MIN, SPEED_MULTIPLIER_MAX)
	health = randi_range(HEALTH_MIN, HEALTH_MAX)

func _physics_process(delta: float) -> void:
	var velocity := Vector2.ZERO
	
	# Преследуем игрока только тогда, когда он существует (не погиб)
	if is_instance_valid(player):
		var target_position := player.global_position
		velocity = global_position.direction_to(target_position)
		velocity = velocity * speed * speed_multiplier * delta
		position += velocity

func _take_damage(value: int) -> void:
	health -= value
	print("Здоровье %s: %s" % [name, health])
	_check_health()

func _check_health() -> void:
	if health <= 0:
		print("%s погиб!" % [name])
		queue_free()

# Привяжите сигнал "area_entered" у "Enemy"
func _on_area_entered(area: Area2D) -> void:
	if area is Bullet:
		_take_damage(area.damage)
		area.queue_free()
	if area is Player:
		is_touches_player = true
		if damage_delay.is_stopped():
			player.take_damage(damage)
			damage_delay.start()

# Привяжите сигнал "area_exited" у "Enemy"
func _on_area_exited(area: Area2D) -> void:
	if area is Player:
		is_touches_player = false

# Привяжите сигнал "timeout" у "DamageDelay"
func _on_damage_delay_timeout() -> void:
	if is_touches_player:
		player.take_damage(damage)
		damage_delay.start()

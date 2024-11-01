class_name Player extends Area2D

const BULLET := preload("res://secondary/bullet/bullet.tscn")

var health := 10

var speed := 100.0
var speed_multiplier := 3.0

@onready var shoot_delay: Timer = $ShootDelay

func _physics_process(delta: float) -> void:
	# Создаётся вектор направления от (-1,-1) до (1,1)
	# Направления:
	# - Отрицательные значения: left, forward;
	# - Положительные значения: right, backward;
	# Объясняется это тем, что координата (0,0) - левый верхний угол экрана
	# По горизонтали (слева направо) : (-X,0,X+)
	# По веритикали  (сверху вниз)   : (-Y,0,Y+) 
	var direction_x := Input.get_axis("left", "right")
	var direction_y := Input.get_axis("forward", "backward")
	
	var velocity := Vector2(direction_x, direction_y)
	velocity = velocity.normalized()
	velocity = velocity * speed * speed_multiplier * delta
	
	position += velocity
	
	if Input.is_action_pressed("shoot"):
		if shoot_delay.is_stopped():
			var bullet := BULLET.instantiate()
			bullet.global_position = global_position
			bullet.look_at(get_global_mouse_position())
			get_parent().add_child(bullet)
			shoot_delay.start()

func take_damage(value: int) -> void:
	health -= value
	print("Здоровье игрока: ", health)
	_check_damage()

func _check_damage() -> void:
	if health <= 0:
		print("Игрок погиб!")
		queue_free()

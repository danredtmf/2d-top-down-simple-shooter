class_name Bullet extends Area2D

var damage := 1

var speed := 100.0
var speed_multiplier := 5.0

@onready var timer: Timer = $Timer

func _physics_process(delta: float) -> void:
	position += transform.x * speed * speed_multiplier * delta

# Привяжите сигнал "screen_exited" у "VisibleOnScreenNotifier2D"
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	timer.start()

# Привяжите сигнал "timeout" у "Timer"
func _on_timer_timeout() -> void:
	queue_free()

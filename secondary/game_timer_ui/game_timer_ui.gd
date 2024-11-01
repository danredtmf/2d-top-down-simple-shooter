class_name GameTimerUI extends Control

@export var timer: GameTimer

@onready var timer_name: Label = %TimerName
@onready var timer_info: Label = %TimerInfo

func _process(_delta: float) -> void:
	if is_instance_valid(timer):
		var raw_seconds := timer.time_left
		var minutes: int = floor(float(raw_seconds % 3600) / 60)
		var seconds: int = raw_seconds % 60
		timer_info.text = "%02d:%02d" % [minutes, seconds]

# Привяжите сигнал "timeout" у "Timer"
func _on_timer_timeout() -> void:
	if not is_instance_valid(timer):
		timer = get_tree().get_first_node_in_group("GameTimer")

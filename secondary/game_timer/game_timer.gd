class_name GameTimer extends Node2D

signal timeout

@export var seconds: int = 60
var time_left: int

@onready var delay: Timer = $Delay

func _ready() -> void:
	time_left = seconds
	delay.start()

func _check() -> void:
	if time_left <= 0:
		delay.stop()
		timeout.emit()

# Привяжите сигнал "timeout" у "Delay"
func _on_delay_timeout() -> void:
	time_left -= 1
	_check()

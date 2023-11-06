extends Node2D

func _init() -> void:
	var _screen_size: Vector2 = OS.get_screen_size()
	var _window_size: Vector2 = OS.get_window_size()
	OS.set_window_position(Vector2(289, 100))

func _ready():
	
	$AnimationPlayer.play("Fade In")
	yield(get_tree().create_timer(6), "timeout")
	$AnimationPlayer.play("Fade Out")
	yield(get_tree().create_timer(3), "timeout")
	get_tree().change_scene("res://Menu Scene.tscn")
	
	

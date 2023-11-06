extends Control

onready var Audio = $Audio

func _ready():
	Audio.play()

func _on_Start_pressed():
	get_tree().change_scene_to_file("res://Game.tscn")
	
func _on_Quit_pressed():
	get_tree().quit()

func _on_Lore_pressed():
	get_tree().change_scene_to_file("res://Lore.tscn")

func _on_Us_pressed():
	get_tree().change_scene_to_file("res://About Us.tscn")

extends Node2D

onready var Head = $Area2D/TowerHead
var bullet = preload("res://Bullet.tscn")
var building = true
var enemies = []
var current_enemy = []
onready var DisappearTimer = $Area2D/DisappearTimer



func _physics_process(delta):
	if building == false:
		if enemies != []:
			current_enemy = enemies[0]
			Head.look_at(current_enemy.global_position)
	else:
		global_position = get_global_mouse_position()
		if Input.is_action_just_pressed("click"):
			if can_place_tower(global_position):
				building = false
				get_parent().tower_built()

func can_place_tower(position):
	for tower in get_tree().get_nodes_in_group("TowerGroup"):  # Adjust the group name
		if tower.get_collision_shape().get_global_rect().has_point(position):
			return false  

	return true 

func _on_ShootTimer_timeout():
	if building == false:
		if current_enemy:
			if enemies: 
				if current_enemy == enemies[0]:
					var b = bullet.instance()
					b.global_position = global_position
					b.target = current_enemy
					get_parent().add_child(b)



func _on_Sight_area_entered(area):
	if area.is_in_group("Enemy"):
		if building == false:
			enemies.append(area)

func _on_Sight_area_exited(area):
	if area.is_in_group("Enemy"):
		if building == false:
			enemies.erase(area)

onready var Tower = $Area2D/CollisionShape2D



func _on_Area2D_area_entered(area):
	if area.is_in_group("Enemy"):
		if building == false:
			queue_free()



func _on_DisappearTime_timeout():
	queue_free()

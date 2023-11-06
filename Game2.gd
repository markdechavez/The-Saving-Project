extends Node2D


var money = 800
var wave = 0
var mobs_left = 0
var wave_mobs = [5, 6, 10, 20, 40, 5, 6, 10, 20, 40, 5, 6, 10, 20, 40, 5, 6, 10, 20, 40]
var wave_speed = [0.5, 0.5, 0.3, 1, 0.3, 0.3, 0.2, 0.2, 0.2, 1, 1, 0.3, 0.5, 1, 0.3, 0.2, 0.1, 0.2, 0.3, 0.5]


var instance
var instance2
var enemy = preload("res://Enemy.tscn")
var tower = preload("res://Tower.tscn")
var tower2 = preload("res://Tower2.tscn")

onready var planet = $Area2D/Sprite

var building = false

func _ready():
	$WaveTimer.start()
	
func add_money(amount):
	money += amount
	print("Money added: " + str(amount) + ", Total money: " + str(money))

func tower_built():
	building = false
	money -= 20
	print("Tower 1 built. Money deducted: 20, Remaining money: " + str(money))

func tower2_built():
	building = false
	money -= 45
	print("Tower 2 built. Money deducted: 45, Remaining money: " + str(money))

func _on_WaveTimer_timeout():
	mobs_left = wave_mobs[wave]
	$MobTimer.wait_time = wave_speed[wave]
	$MobTimer.start()

func _on_MobTimer_timeout():
	var instance1 = enemy.instance()
	$Path2D.add_child(instance1)
	mobs_left -= 1
	if mobs_left <= 0:
		$MobTimer.stop()
		wave += 1
		if wave < len(wave_mobs):
			$WaveTimer.start()
		else:
			get_tree().change_scene("res://Win.tscn")

func _on_Button1_pressed():
	if building == false and money >= 20:
		building = true
		tower_built()
		instance = tower.instance()
		add_child(instance)
		$GUI/CashLabel.text = "HP: " + str(money) 

func _on_Button2_pressed():
	if building == false and money >= 45:
		building = true
		tower2_built()
		instance2 = tower2.instance()
		add_child(instance2)
		$GUI/CashLabel.text = "HP: " + str(money) 

func _process(delta):
	$GUI/CashLabel.text = "HP: " + str(money)

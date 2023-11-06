extends Node2D

var money = 400
var wave = 0
var mobs_left = 0
var wave_mobs = [5,6,10,20,40,0]
var wave_speed = [1,1,0.5,0.5,0.3,5]

var instance
var enemy = preload("res://Enemy.tscn")
var tower = preload("res://Tower.tscn")

onready var planet = $Planet1/CollisionShape2D

var building = false

func _ready():
	$WaveTimer.start()

func _process(delta):
	$GUI/CashLabel.text = "HP: " + str(money)
	
func add_money(amount):
	money += amount

func tower_built():
	building = false
	money -= 20

func _on_WaveTimer_timeout():
	mobs_left = wave_mobs[wave]
	$MobTimer.wait_time = wave_speed[wave]
	$MobTimer.start()


func _on_MobTimer_timeout():
	instance = enemy.instance()
	$Path2D.add_child(instance)
	mobs_left -= 1
	if mobs_left <= 0:
		$MobTimer.stop()
		wave += 1
		if wave < len(wave_mobs):
			$WaveTimer.start()
		else:
			get_tree().change_scene("res://Win.tscn")

func _on_TextureButton_pressed():
	if building == false and money >= 20:
		instance = tower.instance()
		add_child(instance)
		building = true






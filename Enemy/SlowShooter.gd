extends "res://Enemy/Enemy.gd"

class_name slowShooter

onready var fireTimer = $FireTimer

export var fireRate:=1.5




func _process(delta):
	if fireTimer.is_stopped():
		fire()
		fireTimer.start(fireRate)


extends "res://Enemy/Enemy.gd"

export var rotateSpeed : float = 50

func _process(delta):
	
	rotate(deg2rad(rotateSpeed)*delta)
	


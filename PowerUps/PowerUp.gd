extends Area2D
class_name Powerup


export var powerupMoveSpeed : float = 50

func _physics_process(delta):
	position.y += powerupMoveSpeed * delta
	

func applyPowerUp(player:Player):
	pass

func _on_PowerUp_area_entered(area):
	if area is Player:
		
		applyPowerUp(area)
		
		queue_free()






func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

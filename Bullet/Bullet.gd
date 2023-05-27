extends Area2D

export var speed : float = 350
var pbulletEffect := preload("res://Bullet/BulletEffect.tscn")

func _physics_process(delta):
	position.y -= speed*delta





func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Bullet_area_entered(area):
	if (area.is_in_group("damagable")):
		var bulletEffect := pbulletEffect.instance()
		bulletEffect.position = position
		get_parent().add_child(bulletEffect)
		
		var cam := get_tree().current_scene.find_node("Cam",true,false)
		cam.shake(1)
		
		area.damage(1)
		queue_free()

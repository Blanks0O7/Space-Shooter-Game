extends Area2D

var plBullet = preload("res://Bullet/EnemyBullet.tscn")
var plEnemyExplosion = preload("res://Enemy/EnemyExplosion.tscn")

onready var firingPos =$FiringPositions

export var VerticalSpeed : float = 10
export var health: int = 25
var playerInArea : Player = null


func damage(amount : int):
	
	if health <= 0:
		return
	
	health -= amount
	if health <= 0 :
		var effect = plEnemyExplosion.instance()
		effect.global_position = global_position
		get_tree().current_scene.add_child(effect)
		
		Signals.emit_signal("on_Score_increment",25)
		queue_free()

func fire():
	for child in firingPos.get_children():
			var bullet = plBullet.instance()
			bullet.global_position = child.global_position
			get_tree().current_scene.add_child(bullet)

func _physics_process(delta):
	position.y += VerticalSpeed * delta

func _process(delta):
	if playerInArea != null:
		playerInArea.damage(1)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Enemy_area_entered(area):
	if area is Player:
		playerInArea = area


func _on_Enemy_area_exited(area):
	if area is Player:
		playerInArea = null

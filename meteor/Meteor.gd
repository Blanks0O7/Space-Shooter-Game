extends Area2D

var pmeteorEffect := preload("res://meteor/MeteorEffects.tscn")

export var minSpeed:float = 50
export var maxSpeed:float = 100

export var minRotation:float = -20
export var maxRotation:float = 20

export var life:int = 20


var speed:float = 0
var rotationRate:float = 0
var playerInArea: Player = null


func damage(damageAmt : int):
	if life <= 0:
		return
	
	
	
	life -= damageAmt
	if (life<=0):
		var effect = pmeteorEffect.instance()
		effect.position = position
		get_parent().add_child(effect)
		Signals.emit_signal("on_Score_increment",50)
		queue_free()
	

func _ready():
	speed = rand_range(minSpeed,maxSpeed)
	rotationRate = rand_range(minRotation,maxRotation)
	

func _process(delta):
	if playerInArea != null:
		playerInArea.damage(1)

func _physics_process(delta):
	rotation_degrees += rotationRate*delta
	position.y += speed * delta
	
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Meteor_area_entered(area):
	if (area.is_in_group("Player")):
		playerInArea = area
		area.damage(1)






func _on_Meteor_area_exited(area):
	if (area.is_in_group("Player")):
		playerInArea=null

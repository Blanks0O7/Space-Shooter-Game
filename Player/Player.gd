extends Area2D
class_name Player


var plBullet = preload("res://Bullet/Bullet.tscn")

onready var animatedsprite = $AnimatedSprite
onready var firingPos = $FiringPositions
onready var firedelaytimer = $Firedelaytime
onready var invincibilityTimer = $InvincibilityTimer
onready var shieldSprite = $ShieldSprite
onready var rapidFireTimer = $RapidFireTimer
export var speed: float = 100

export var life:int = 3
export var InvincibilityTime := 2
var vel = Vector2(0,0)

export var normalFireDelay :float = 0.12
export var rapidFireDelay :float = 0.06
var fireDelay: float = normalFireDelay

func _ready():
	shieldSprite.visible = false
	Signals.emit_signal("onPlayer_Life_Change",life)


func _process(delta):
	if vel.x<0:
		animatedsprite.play("left")
	elif vel.x > 0 :
		animatedsprite.play("right")
	else:
		animatedsprite.play("straight")
	



func _physics_process(delta):
	var dirvec = Vector2(0,0)
	if Input.is_action_pressed("move_left"):
		dirvec.x = -1
	elif Input.is_action_pressed("move_right"):
		dirvec.x = 1
	if Input.is_action_pressed("move_up"):
		dirvec.y = -1
	elif Input.is_action_pressed("move_down"):
		dirvec.y = 1
	
	#check if player is shooting 
	if Input.is_action_pressed("shoot") and firedelaytimer.is_stopped():
		firedelaytimer.start(fireDelay)
		for child in firingPos.get_children():
			var bullet = plBullet.instance()
			bullet.global_position = child.global_position
			get_tree().current_scene.add_child(bullet)

	
	vel = dirvec.normalized() * speed
	position += vel * delta
	
	var viewrect = get_viewport_rect()
	position.x = clamp(position.x , 0 , viewrect.size.x)
	position.y = clamp(position.y, 0, viewrect.size.y)


func damage(damageAmt:int):
	if !invincibilityTimer.is_stopped():
		return
	
	applyShield(InvincibilityTime)
	
	life -= damageAmt
	Signals.emit_signal("onPlayer_Life_Change", life)
	
	var cam := get_tree().current_scene.find_node("Cam",true,false)
	cam.shake(20)
	
	if(life<=0):
		print("player died")
		queue_free()
		get_tree().change_scene("res://UI/GameOverScreen.tscn")

func applyShield(time:float):
	invincibilityTimer.start(time + invincibilityTimer.time_left)
	shieldSprite.visible = true
	

func applyRapidFire(time:float):
	fireDelay = rapidFireDelay
	rapidFireTimer.start(time + rapidFireTimer.time_left)
	


func _on_InvincibilityTimer_timeout():
	shieldSprite.visible = false


func _on_RapidFireTimer_timeout():
	fireDelay = normalFireDelay

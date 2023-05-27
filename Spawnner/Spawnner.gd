extends Node2D

const MIN_SPAWN_TIME = 2.5

var preloadedEnemies := [
	preload("res://Enemy/FastEnemy.tscn"),
	preload("res://Enemy/BouncerEnemy.tscn"),
	preload("res://Enemy/SlowShooter.tscn")
]

var preloadedPowerUps := [
	preload("res://PowerUps/ShieldPowerUp.tscn"),
	preload("res://PowerUps/RapidFirePowerUp.tscn")
]

var plMeteor := preload("res://meteor/Meteor.tscn")

onready var spawnTimer = $SpawnTimer
onready var powerupSpawnTimer := $PowerUpSpawnTimer


export var nextEnemySpawnTime :float = 5.0


export var minPowerUpSpawnTime :float = 12.0
export var maxPowerUpSpawnTime :float = 55.0



func _ready():
	randomize()
	spawnTimer.start(nextEnemySpawnTime)
	powerupSpawnTimer.start(minPowerUpSpawnTime)

func getRandomSpawnPos() -> Vector2:
	var viewRect := get_viewport_rect()
	var xPos := rand_range(viewRect.position.x,viewRect.end.x)
	return Vector2(xPos,position.y)

func _on_SpawnTimer_timeout():
	#spawn enmy
	if randf()<0.1:
		var meteor := plMeteor.instance()
		meteor.position = getRandomSpawnPos()
		get_tree().current_scene.add_child(meteor)
	else:
		var enemyPreload = preloadedEnemies[randi()%preloadedEnemies.size()]
		var enemy = enemyPreload.instance()
		enemy.position = getRandomSpawnPos()
		get_tree().current_scene.add_child(enemy)
	
	
	#restat timer
	nextEnemySpawnTime -= 0.05
	if nextEnemySpawnTime < MIN_SPAWN_TIME:
		nextEnemySpawnTime=MIN_SPAWN_TIME
	spawnTimer.start(nextEnemySpawnTime)


func _on_PowerUpSpawnTimer_timeout() -> void:
	var powerupPreload = preloadedPowerUps[randi() % preloadedPowerUps.size()]
	var powerup :Powerup = powerupPreload.instance()
	powerup.position = getRandomSpawnPos()
	get_tree().current_scene.add_child(powerup)
	powerupSpawnTimer.start(rand_range(minPowerUpSpawnTime,maxPowerUpSpawnTime))
	
	
	







extends Control



onready var lifeContainer := $Lifecontainer
onready var ScoreLabel := $Label
var score : int = 0

var GameOverScreen := preload("res://UI/GameOverScreen.tscn")
var pLifeIcon := preload("res://HUD/Lifeicon.tscn")

func _ready():
	clearLives()
	
	Signals.connect("onPlayer_Life_Change", self, "_onPlayer_Life_Change")
	Signals.connect("on_Score_increment",self,"_on_Score_increment")
	

func _on_Score_increment(amount:int):
	score += amount
	ScoreLabel.text = str(score)

func _onPlayer_Life_Change(life:int):
	setLives(life)


func clearLives():
	for child in lifeContainer.get_children():
		lifeContainer.remove_child(child)
		child.queue_free()
		

func setLives(lives:int):
	clearLives()
	for i in range(lives):
		lifeContainer.add_child(pLifeIcon.instance())
		
		

func handleGameOver():
	var game_over = GameOverScreen.instance()
	add_child(game_over)


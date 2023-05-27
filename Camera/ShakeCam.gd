extends Camera2D

export var shakeBaseAmount :float = 1.0
export var shakeDampening :float = 0.075

var ShakeAmount :float = 0.0



func _process(delta):
	if ShakeAmount>0:
		position.x = rand_range(-shakeBaseAmount,shakeBaseAmount) * ShakeAmount
		position.y = rand_range(-shakeBaseAmount,shakeBaseAmount) * ShakeAmount
		ShakeAmount = lerp(ShakeAmount,0.0,shakeDampening)
		pass
	else:
		position = Vector2(0,0)
	

func shake(magnitude:float):
	ShakeAmount+= magnitude

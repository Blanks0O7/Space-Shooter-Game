extends Powerup

export var shieldTime :float = 6


func applyPowerUp(player:Player):
	player.applyShield(shieldTime)



extends Powerup

export var rapidFireTime :float = 4.5

func applyPowerUp(player:Player):
	player.applyRapidFire(rapidFireTime)



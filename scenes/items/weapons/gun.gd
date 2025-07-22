extends Weapon

func _input(event):
	if event.is_action_pressed("attack_primary"):
		attack()

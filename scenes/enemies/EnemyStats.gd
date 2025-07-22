extends Resource
class_name EnemyStats

@export var hp: float

func take_damage(n: float):
	hp -= n
	print("HP: ", hp)

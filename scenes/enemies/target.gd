extends StaticBody3D

@export var stats: EnemyStats

func hit(damage: float):
	stats.take_damage(damage * 0)
	if stats.hp <= 0:
		queue_free()

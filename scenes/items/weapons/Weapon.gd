class_name Weapon extends Item

@export var stats: WeaponStats
@onready var bullet_spawn: Node3D = $BulletSpawn

func attack():
	var projectile = stats.projectile_scene.instantiate()
	
	print(bullet_spawn.global_position)
	projectile.transform.origin = bullet_spawn.global_position
	
	projectile.damage = stats.damage
	projectile.speed = stats.speed
	get_tree().current_scene.add_child(projectile)

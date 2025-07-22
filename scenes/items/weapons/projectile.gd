extends RigidBody3D
class_name Projectile

@export var speed: float = 5.0
@export var damage: float = 1.0

func _process(delta: float) -> void:
	move_and_collide(-transform.basis.z * delta * speed)

func _on_hitbox_body_entered(body: Node3D) -> void:
	if body.is_in_group("Enemy"):
		print("Hit " + body.to_string())
		queue_free()

func _on_timer_timeout() -> void:
	queue_free()

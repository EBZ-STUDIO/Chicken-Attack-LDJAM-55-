extends RigidBody3D

func force():
	apply_force(transform.basis * Vector3(0, 0, -750))

func _physics_process(delta):
	if get_contact_count() > 0:
		queue_free()

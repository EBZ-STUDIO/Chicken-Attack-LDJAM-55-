extends Marker3D

const CHICKEN_PRELOAD = preload("res://Modules/Chicken/chicken.tscn")

func _physics_process(delta):
	if Input.is_action_just_pressed("a_shoot"):
		var chicken_obj = CHICKEN_PRELOAD.instantiate()
		get_parent().get_parent().get_parent().add_child(chicken_obj)
		chicken_obj.transform = global_transform
		chicken_obj.rotation.y = $"../..".rotation.y
		chicken_obj.rotation.x = $"..".rotation.x
		chicken_obj.force()

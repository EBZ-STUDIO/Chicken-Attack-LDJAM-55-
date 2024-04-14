extends Node3D

const CHICKEN_PRELOAD = preload("res://Modules/Chicken/chicken.tscn")
var state = "idle"
var bulletReady = true

func _physics_process(delta):
	shootLogic()

func shootLogic():
	if Input.is_action_just_pressed("a_shoot") and bulletReady:
		bulletReady = false
		var chicken_obj = CHICKEN_PRELOAD.instantiate()
		get_parent().get_parent().get_parent().add_child(chicken_obj)
		chicken_obj.transform = $objs/Marker3D.global_transform
		chicken_obj.rotation.y = $"../..".rotation.y
		chicken_obj.rotation.x = $"..".rotation.x
		chicken_obj.force()
		$Timer.start()
		$AnimationPlayer.play("Shoot")
		$AudioStreamPlayer3D.play()

func _on_timer_timeout():
	bulletReady = true
	$AnimationPlayer.play("RESET")

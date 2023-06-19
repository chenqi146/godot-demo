extends StaticBody2D

class_name ResourceNode

@export var node_types : Array[ResourceNodeType]
@export var starting_resource : int 
@export var pickup_type : PackedScene
@export var launch_speed : float = 100
@export var launch_duration : float = 0.25
var current_resources : int :
	set(value):
		current_resources = value
		if value <= 0:
			queue_free()

func _real() -> void:
	current_resources = starting_resource
 

func harvest(amount: int):
	for n in amount:
		spawn_resource()
	current_resources -= amount
	clamp(current_resources, 0, current_resources)

func spawn_resource():
	var pickup_instance : Pickup = pickup_type.instantiate() as Pickup
	# 设置位置, 资源节点周围
	get_parent().add_child(pickup_instance)
	pickup_instance.position = position
	var direction : Vector2 = Vector2(
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0)
	).normalized()
	pickup_instance.launch(direction * launch_speed, launch_duration)

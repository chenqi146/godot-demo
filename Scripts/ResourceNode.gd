extends StaticBody2D

class_name ResourceNode

@export var node_types : Array[ResourceNodeType]
@export var starting_resource : int 
@export var pickup_type : PackedScene
var current_resources : int :
	set(value):
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

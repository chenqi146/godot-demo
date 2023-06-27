extends Node2D

class_name ResourceNode

@export var node_types : Array[ResourceNodeType]
@export var starting_resource : int 
@export var pickup_type : PackedScene
@export var launch_speed : float = 100
@export var launch_duration : float = 0.25
var is_harverst = true
var last_interact_dto : InteractDto
var current_resources : int :
	set(value):
		current_resources = value
		if value <= 0:
			is_harverst = false
			_resources_run_out()

func _ready() -> void:
	current_resources = starting_resource
 
# 资源用完了
func _resources_run_out():
	queue_free()

# 收获之后, 可以设置动画
func _after_harvest(dto: InteractDto):
	pass

# 收获动作离开
func harvest_exit(dto: InteractExitDto):
	pass
	
func harvest(dto: InteractDto):
	if !is_harverst:
		return
	last_interact_dto = dto
	var amount = dto.amount
	for n in amount:
		spawn_resource()
	current_resources -= amount
	clamp(current_resources, 0, current_resources)
	_after_harvest(dto)

func spawn_resource():
	var pickup_instance : Pickup = pickup_type.instantiate() as Pickup
	# 设置位置, 资源节点周围
	get_parent().call_deferred("add_child", pickup_instance)
	pickup_instance.position = position
	var direction : Vector2 = Vector2(
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0)
	).normalized()
	pickup_instance.launch(direction * launch_speed, launch_duration)

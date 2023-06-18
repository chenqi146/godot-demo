extends EquippableItem

class_name HarvestingTool

@export var min_amount : int = 1
@export var max_amount : int = 1
@export var effected_types : Array[ResourceNodeType]

# 资源与工具交互
func interact_with_body(body):
	if (body is ResourceNode):
		print("Interact with resource node")
		for type in effected_types:
			if (body.node_types.has(type)):
				print_debug("Fount at type " + type.resource_name + " on " + body.resource_name)
				body.harvest(randi_range(min_amount, max_amount))

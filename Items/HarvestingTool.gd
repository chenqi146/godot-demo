extends EquippableItem

class_name HarvestingTool

@export var min_damage : int = 1
@export var max_damage : int = 1

func harvest(resource_node):
	pass


func interact_with_body(body):
	if (body is ResourceNode):
		print("Interact with resource node")

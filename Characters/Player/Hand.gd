@tool
extends Sprite2D
@export var equipped_item : HarvestingTool :
	set(next_item):
		equipped_item = next_item
		self.texture = equipped_item.texture

func _ready() -> void:
	await owner.ready
	if equipped_item.has_method("_load_owner"):
		equipped_item._load_owner(owner)

func _on_hitbox_hit(body) -> void:
	if equipped_item.has_method("interact_with_body"):
		equipped_item.interact_with_body(body)



func _on_hitbox_hit_exit(body) -> void:
	if equipped_item.has_method("interact_with_body_exit"):
		equipped_item.interact_with_body_exit(body)

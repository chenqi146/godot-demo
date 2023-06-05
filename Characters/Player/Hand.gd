@tool
extends Sprite2D

@export var equipped_item : EquippableItem :
	set(next_item):
		equipped_item = next_item
		self.texture = equipped_item.texture

func _on_hitbox_hit(body) -> void:
	if body.has_method("interact_with_body"):
		body.interact_with_body(body)

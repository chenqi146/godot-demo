@tool
extends Sprite2D
@onready var hitBox : Area2D = $Hitbox
@export var equipped_item : EquippableItem :
	set(next_item):
		equipped_item = next_item
		self.texture = equipped_item.texture

func _on_hitbox_hit(body) -> void:
	if equipped_item.has_method("interact_with_body"):
		equipped_item.interact_with_body(body)


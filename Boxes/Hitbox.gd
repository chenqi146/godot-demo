extends Area2D

signal hit

func _ready() -> void:
	print(get_parent().name + " hit layer " + str(self.collision_layer))
	print(get_parent().name + " hit mask " + str(self.collision_mask))



func _on_area_entered(hutbox: Area2D) -> void:
	emit_signal("hit", hutbox)
	hutbox.emit_signal("hurt", self)

extends Area2D

class_name Hitbox
signal hit(hutbox)
signal hit_exit(hutbox)

func _ready() -> void:
	print(get_parent().name + " hit layer " + str(self.collision_layer))
	print(get_parent().name + " hit mask " + str(self.collision_mask))



func _on_area_entered(hutbox: Area2D) -> void:
	print_debug("_on_area_entered")
	emit_signal("hit", hutbox)
	hutbox.emit_signal("hurt", self)


func _on_area_exited(hutbox: Area2D) -> void:
	print_debug("_on_area_exited")
	emit_signal("hit_exit", hutbox)
	hutbox.emit_signal("hurt_exit", self)

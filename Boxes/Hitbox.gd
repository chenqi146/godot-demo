extends Area2D

signal hit

func _on_area_entered(hurtbox: Area2D):
	emit_signal("hit", hurtbox)
	hurtbox.emit_signal("hurt")

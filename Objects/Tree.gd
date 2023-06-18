extends Sprite2D

@onready var animation_player = $AnimationPlayer


func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass
	

func _on_hutbox_hurt(body) -> void:
	animation_player.play("Attacked")
	# todo
	# 碰撞后播放动画, 然后没有碰撞恢复原来的动画


func _on_hutbox_hurt_exit(body) -> void:
	animation_player.play("Idle")

extends ResourceNode

@onready var animation_player = $AnimationPlayer
@onready var sprite = $TreeSprite

func _process(delta: float) -> void:
	pass
	
	
func _resources_run_out():
	# 死亡调整为一个动画, 根据被击打方向来确定往哪边倒下
	animation_player.play("Death")
	var player = last_interact_dto.interact_player
	var relativePosition = player.global_transform.origin - self.global_transform.origin
	var dotProduct = self.global_transform.x.dot(relativePosition)
	# Player is on the left side of the current object
	if dotProduct < 0:
		sprite.scale.x = -1
	


func _after_harvest(dto: InteractDto):
	if is_harverst:
		var hitPlayer = dto.interact_player
		var direction = (hitPlayer.position - position).normalized()
		animation_player.play("Attacked")


func harvest_exit(dto: InteractExitDto):
	if is_harverst:
		animation_player.play("Idle")

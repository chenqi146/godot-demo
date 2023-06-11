extends PlayerState




# 动画开始之前
func enter() -> void:
	player.update_state(player.PLAYER_STATE.SWING)
	player.state_machine.travel("Swing")
	player.velocity = Vector2.ZERO
	player.hand.visible = true
	

# 物理处理  -> `_physics_process()`
func physics_update(delta: float) -> void:
	if player.current_state != player.PLAYER_STATE.SWING:
		state_machine.transition_to("Idle")
		
# 动画结束
func exit() -> void:
	player.hand.visible = false
	player.hitboxCollisionShape2D.set_deferred("disabled", true)

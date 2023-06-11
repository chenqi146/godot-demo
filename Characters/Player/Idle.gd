extends PlayerState





# 动画开始之前
func enter() -> void:
	player.current_state = player.PLAYER_STATE.IDLE
	player.state_machine.travel("Idle")
	player.velocity = Vector2.ZERO


# 物理处理  -> `_physics_process()`
func physics_update(delta: float) -> void:
	if Input.is_action_pressed("down") or \
		Input.is_action_pressed("left") or \
		Input.is_action_pressed("right") or \
		Input.is_action_pressed("up"):
		state_machine.transition_to("Walk")
	elif Input.is_action_pressed("swing"):
		state_machine.transition_to("Swing")
		
# 动画结束
func exit() -> void:
	pass

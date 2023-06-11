extends PlayerState




# 动画开始之前
func enter() -> void:
	player.update_state(player.PLAYER_STATE.WALK)
	player.state_machine.travel("Walk")
	
# 物理处理  -> `_physics_process()`
func physics_update(delta: float) -> void:
	
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	if Input.is_action_pressed("down") or \
		Input.is_action_pressed("left") or \
		Input.is_action_pressed("right") or \
		Input.is_action_pressed("up"):
		player.update_state(player.PLAYER_STATE.WALK)
		state_machine.transition_to("Walk")
		player.velocity = input_direction.normalized() * player.move_speed
		player.update_animation_parameters(input_direction)
		player.move_and_slide()
	elif Input.is_action_pressed("swing"):
		state_machine.transition_to("Swing")
	elif input_direction == Vector2.ZERO:
		state_machine.transition_to("Idle")
	
# 动画结束
func exit() -> void:
	pass

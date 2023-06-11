extends Node

class_name State

# 状态管理机
var state_machine = null

# 处理按键事件
func handle_input(_event: InputEvent) -> void:
	pass
	
# 处理  -> `_process()`
func update(_delta: float) -> void:
	pass
	
# 物理处理  -> `_physics_process()`
func physics_update(delta: float) -> void:
	pass


# 动画开始之前
func enter() -> void:
	pass
	
# 动画结束
func exit() -> void:
	pass

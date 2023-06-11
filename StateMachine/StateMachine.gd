extends Node

class_name StateMachine


signal transitioned(state_name)

@export var state : State

func _ready() -> void:
	await owner.ready
	print("state machine ready")
	for child in get_children():
		child.state_machine = self
	if is_instance_valid(state):
		state.enter()
		


# The state machine subscribes to node callbacks and delegates them to the various 
# state objects (i.e. idle, fall, etc).
func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


# Handle transitioning to new state. There is an option to pass in msg, but I
# removed it.  See GDquest
func transition_to(target_state_name: String) -> void:
	# if there is no new state, return so there is no transition
	if not has_node(target_state_name):
		return

	# if there is new state, then exit current state and go to new state.
	state.exit()
	state = get_node(target_state_name)
	state.enter()
	emit_signal("transitioned", state.name)

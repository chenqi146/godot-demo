extends CharacterBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@export var move_speed : float = 100
@export var starting_direction : Vector2 =  Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
# Called when the node enters the scene tree for the first time.

enum PLAYER_STATE { IDLE, WALK, DIG}
var current_state : PLAYER_STATE = PLAYER_STATE.IDLE
func _ready():
	update_animation_parameters(starting_direction)

func _physics_process(_delta):

	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	if Input.is_action_pressed("down") or \
		Input.is_action_pressed("left") or \
		Input.is_action_pressed("right") or \
		Input.is_action_pressed("up"):
		current_state = PLAYER_STATE.WALK
		state_machine.travel("Walk")
		velocity = input_direction.normalized() * move_speed
		update_animation_parameters(input_direction)
		move_and_slide()
	elif Input.is_action_pressed("dig"):
		current_state = PLAYER_STATE.DIG
		state_machine.travel("Dig")
		velocity = Vector2.ZERO
	else:
		current_state = PLAYER_STATE.IDLE
		state_machine.travel("Idle")
		velocity = Vector2.ZERO
	
 

func update_animation_parameters(move_input : Vector2):
	animation_tree.set("parameters/Idle/blend_position", move_input)
	animation_tree.set("parameters/Walk/blend_position", move_input)
	animation_tree.set("parameters/Dig/blend_position", move_input)
	


func _on_hitbox_hit(box: Area2D):
	var o = box.owner
	print(box.owner)

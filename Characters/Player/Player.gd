extends CharacterBody2D

class_name Player
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@export var move_speed : float = 100
@export var starting_direction : Vector2 =  Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var hand : Sprite2D = $Hand
@onready var hitboxCollisionShape2D : CollisionShape2D = $Hand/Hitbox/CollisionShape2D
# Called when the node enters the scene tree for the first time.

enum PLAYER_STATE { IDLE, WALK, SWING}
var current_state : PLAYER_STATE = PLAYER_STATE.IDLE
func _ready():
	update_animation_parameters(starting_direction)

func update_state(state: PLAYER_STATE) -> void:
	current_state = state

func on_swing_finished():
	current_state = PLAYER_STATE.IDLE
 

func update_animation_parameters(move_input : Vector2):
	animation_tree.set("parameters/Idle/blend_position", move_input)
	animation_tree.set("parameters/Walk/blend_position", move_input)
	animation_tree.set("parameters/Swing/blend_position", move_input)
	

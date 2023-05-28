extends CharacterBody2D

enum COW_STATE { IDLE, WALK}

@export var move_speed : float = 20
@export var idle_time : float = 5
@export var walk_time : float = 2

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var sprite = $Sprite2D
@onready var timer = $Timer


var move_direction : Vector2 = Vector2.ZERO
var current_state : COW_STATE = COW_STATE.IDLE

func _ready():
	pick_new_state()
	
func _physics_process(_delta):
	if (current_state == COW_STATE.WALK):
		velocity = move_direction.normalized() * move_speed
		move_and_slide()
	
func select_new_directon():
	move_direction = Vector2(
		randi_range(-1, 1),
		randi_range(-1, 1)
	)

	# 默认方向为向左
	if (move_direction.x < 0):
		# true -> 翻转
		sprite.flip_h = true
	elif (move_direction.x > 0):
		sprite.flip_h = false

func pick_new_state():
	if (current_state == COW_STATE.IDLE):
		state_machine.travel("walk_right")
		current_state = COW_STATE.WALK
		select_new_directon()
		timer.start(walk_time)
	elif (current_state == COW_STATE.WALK):
		state_machine.travel("idle_right")
		current_state = COW_STATE.IDLE
		timer.start(idle_time)


func _on_timer_timeout():
	pick_new_state()

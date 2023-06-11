extends Sprite2D


# 导入 HealthSystem 类型
const HealthSystem = preload("res://Scripts/HealthSystem.gd")

@onready var healthSystem  = $HealthSystem
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# 死亡
func _onDestroyed():
	pass

# 生命值变化
func _onHealthChanged(health: int):
	# 处理生命值变化的逻辑
	pass



func _on_hutbox_hurt(body):
	healthSystem.minusHealth(20)


extends Sprite2D

# 导入 HealthSystem 类型
const HealthSystem = preload("res://Scripts/HealthSystem.gd")

@onready var healthBar : ProgressBar = $ProgressBar
var healthSystem : HealthSystem
# Called when the node enters the scene tree for the first time.
func _ready():
	healthSystem = $HealthSystem
	healthSystem.connect("healthChanged", Callable(self, "_onHealthChanged"))
	healthSystem.setHealthBar(healthBar)

func _onHealthChanged(health: int):
	# 处理生命值变化的逻辑
	var maxHealth = healthSystem.maxHealth
	var healthPercentage = float(health) / maxHealth
	print("当前生命值：", health)

func damagePlayer(damage: int):
	healthSystem.takeDamage(damage)

func healPlayer(amount: int):
	healthSystem.heal(amount)

func _on_hutbox_hurt():
	damagePlayer(20)

extends Node
class_name  HealthSystem
@export var maxHealth : int = 100
@export var regenRate: float = 5.0  # 每秒回血的速率
@export var regenDelay: float = 3.0  # 未受攻击时开始回复血量的延迟时间
@export var healthBar: ProgressBar  # 血条节点
var currentHealth : int = maxHealth :
	set(value):
		currentHealth = clamp(value, 0, maxHealth)
		updateHealthBar()
		if currentHealth == 0:
			emit_signal("destroyed")
			owner.queue_free()
		if currentHealth == maxHealth:
			stopRegenTimer()
			
var regenTimer: Timer
var attrackedTimer: Timer

signal healthChanged(health: int)
signal destroyed()

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("healthChanged", currentHealth)

	# 创建并启动计时器
	regenTimer = Timer.new()
	regenTimer.connect("timeout", Callable(self, "_onRegenTimerTimeout"))
	regenTimer.wait_time = 1.0
	regenTimer.one_shot = false
	add_child(regenTimer)

	attrackedTimer = Timer.new()
	attrackedTimer.connect("timeout", Callable(self, "_onAttrackedTimerTimeout"))
	attrackedTimer.wait_time = regenDelay
	add_child(attrackedTimer)
	currentHealth = maxHealth
	
func resetAttrackedTimer():
	# 未受攻击定时器关闭时开启, 开启时重置定时器
	if attrackedTimer.is_stopped():
		attrackedTimer.start()
	else:
		attrackedTimer.stop()
		attrackedTimer.start()

func stopRegenTimer():
	if not regenTimer.is_stopped():
		regenTimer.stop()

func _onRegenTimerTimeout():
	# 每次回血regenRate点
	plusHealth(regenRate)  
	
func _onattrackedTimerTimeout():
	regenTimer.start()
		
	
func minusHealth(amount: int):
	currentHealth = clamp(currentHealth - amount, 0, maxHealth)
	emit_signal("healthChanged", currentHealth)
	resetAttrackedTimer()
	stopRegenTimer()

func plusHealth(amount: int):
	currentHealth = clamp(currentHealth + amount, 0, maxHealth)
	emit_signal("healthChanged", currentHealth)
	attrackedTimer.stop()

func updateHealthBar():
	if healthBar == null:
		return
	healthBar.value = currentHealth
	healthBar.visible = healthBar.value != maxHealth

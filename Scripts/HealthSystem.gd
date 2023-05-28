extends Node

@export var maxHealth : int = 100
@export var regenRate: float = 5.0  # 每秒回血的速率
@export var regenDelay: float = 3.0  # 未受攻击时开始回复血量的延迟时间

var currentHealth : int = maxHealth
var regenTimer: Timer
var regenDelayTimer: Timer
var healthBar: ProgressBar  # 血条节点

signal healthChanged(health: int)

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("healthChanged", currentHealth)

	# 创建并启动计时器
	regenTimer = Timer.new()
	regenTimer.connect("timeout", Callable(self, "_onRegenTimerTimeout"))
	regenTimer.wait_time = 1.0 / regenRate
	regenTimer.one_shot = false
	add_child(regenTimer)

	regenDelayTimer = Timer.new()
	regenDelayTimer.connect("timeout", Callable(self, "_onRegenDelayTimerTimeout"))
	regenDelayTimer.wait_time = regenDelay
	add_child(regenDelayTimer)
	
	startRegenDelayTimer()

func startRegenDelayTimer():
	# 未受攻击定时器关闭时开启, 开启时重置定时器
	if regenDelayTimer.is_stopped():
		regenDelayTimer.start()
	else:
		regenDelayTimer.stop()
		regenDelayTimer.start()
	if not regenTimer.is_stopped():
		regenTimer.stop()
		
func _onRegenTimerTimeout():
	heal(1)  # 每次回血1点
	
func _onRegenDelayTimerTimeout():
	if currentHealth < maxHealth:
		regenTimer.start()
	
func takeDamage(damage: int):
	currentHealth -= damage
	currentHealth = max(currentHealth, 0)
	emit_signal("healthChanged", currentHealth)
	updateHealthBar()
	startRegenDelayTimer()

func heal(amount: int):
	currentHealth += amount
	currentHealth = min(currentHealth, maxHealth)
	emit_signal("healthChanged", currentHealth)
	updateHealthBar()
	if currentHealth == maxHealth:
		regenTimer.stop()

func updateHealthBar():
	if healthBar != null:
		healthBar.value = currentHealth
		if healthBar.value == maxHealth:
			healthBar.visible = false
		else:
			healthBar.visible = true


func setHealthBar(bar: ProgressBar):
	healthBar = bar
	updateHealthBar()

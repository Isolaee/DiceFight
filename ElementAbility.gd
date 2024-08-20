extends Node

var isReady: bool = true
var element = $Player.getElement()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("elementAbility") and isReady:
		isReady = false
		$CooldownTimer.start()
		print("Element Ability pressed")


func _on_cooldown_timer_timeout() -> void:
	isReady = true

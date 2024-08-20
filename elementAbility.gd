extends Node

var isReady:bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	activate()


func activate():
	if Input.is_action_just_pressed("elementAbility") and isReady:
		# Ability here
		# Some ability
		isReady = false
		$CooldownTimer.start()
		print("Element ability activated")

func _on_timer_timeout() -> void:
	isReady = true

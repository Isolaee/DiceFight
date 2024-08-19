extends CharacterBody2D
@export var bullet : PackedScene

const walkMaxSpeed = 200.0
const walkForce = 600
const stopForce = 1300
const jumpSpeed = 200
const gravity = 200

func _physics_process(_delta: float) -> void:
	move()
	shoot()
		
@onready var _animated_sprite = $AnimatedSprite2D

func _process(_delta):
	if Input.is_action_pressed("ui_right"):
		_animated_sprite.flip_h = false
		_animated_sprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		_animated_sprite.flip_h = true
		_animated_sprite.play("Run")
	elif Input.is_action_pressed("ui_up"):
		_animated_sprite.play("Jump")
	elif velocity == Vector2(0,0):
		_animated_sprite.play("Idle")
	else:
		_animated_sprite.stop()
	
func shoot():
	if Input.is_action_just_pressed("fire"):
		var b = bullet.instantiate()
		get_node("/root/World").add_child(b)
		get_parent().add_child(b)
		b.shoot(get_global_mouse_position(), $Gun/GunSprite/Barrel.global_position)
	
func move():
	# Horizontal
	var walk := walkForce * (Input.get_axis(&"ui_left", &"ui_right"))
	
	# Slow the player down, when they are not trying to move.
	if abs(walk) < walkForce * 0.2:
		velocity.x	= move_toward(velocity.x, 0, stopForce)
	else:
		velocity.x += walk * 0.2
		
	#  Clamp the maximum horizontal ms
	velocity.x = clamp(velocity.x, -walkMaxSpeed, walkMaxSpeed)
	
	# Gravity
	velocity.y += gravity
	
	move_and_slide()
	
	if is_on_floor() and Input.is_action_just_pressed(&"ui_up"):
		velocity.y = -jumpSpeed

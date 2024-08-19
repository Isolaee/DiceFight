extends CharacterBody2D
class_name Player

# Phys vars
const walkMaxSpeed = 200.0
const walkForce = 600
const stopForce = 1300
const jumpSpeed = 300
const gravity = 5
# Time vars
var time_start = 0
var time_now = 0

#Player attributes
var health: int = 100
var regen: int = 1
var dead: bool = false
var element:String = "empty"

func _ready() -> void:
	time_start = Time.get_ticks_msec()

func _init() -> void:
	pass

func _physics_process(_delta: float) -> void:
	move()
		

func _process(_delta):
	animations()
	deadOrAlive()
	fire()
	timeUpdate()
	regenerate()
	
# Function to get players health
	# returns healt:int
func getHealth():
	return self.health
	
# Function to calculate dmg
func damage(dmg):
	self.health + dmg

# Function to calculate regen
func regenerate():
	self.health + regen

# Function to check if player is dead
func deadOrAlive():
	if self.health <= 0:
		self.dead = true

# Function for animations
@onready var _animated_sprite = $AnimatedSprite2D
func animations():
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
		
# Function to pull the trigger
func pullTheTrigger():
	$Gun.shoot()

# Function to get fire input
func fire():
	if Input.is_action_just_pressed("fire"):
		#gunCoolDown()
		pullTheTrigger()
		
# Function for time tracking
func timeUpdate():
	time_now = time_start + 1

# Function to move
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

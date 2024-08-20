extends CharacterBody2D
class_name Player
class_name Player

# Phys vars
# Phys vars
const walkMaxSpeed = 200.0
const walkForce = 600
const stopForce = 1300
const jumpSpeed = 600
const gravity = 30

# Player attributes
var health: int = 100
var maxHealth:int = 100
var regen:int = 1
var dead: bool = false
var element:String = "empty"

func _physics_process(_delta: float) -> void:
	move()
		

func _process(_delta):
	animation()
	pullTheTrigger()
	deadOrAlive()
	regenerate()
	
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
		
func animation():
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

func pullTheTrigger()->void:
	if Input.is_action_just_pressed("fire"):
		$Gun.shoot()

# Get player health		
func getHealt()->int:
	return self.health

# Calcualte dmg
func receiveDamage(dmg)-> void:
	self.health -= dmg

# Set regen
func setRegen(extraRegen)->void:
	self.regen += extraRegen

# Apply regen
func Regenerate()->void:
	if health < maxHealth:
		self.health = health + regen
	else:
		pass

# Function to check if player is dead
func deadOrAlive():
	if self.health <= 0:
		self.dead = true

extends Node2D

var magSize = 25

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	look_at_mouse()
	
	if Input.is_action_pressed("fire"):
		# UsePrimitiveMag()
		pass

func look_at_mouse():
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	
func UsePrimitiveMag():
	if magSize < 0:
		reload()
	else:
		shoot()
		magSize -= 1
	

	
@export var Bullet : PackedScene

func shoot():
	var b = Bullet.instantiate()
	get_node("/root/World").add_child(b)
	b.add_to_group("Bullets")
	b.global_position = $GunSprite/Barrel.global_position
	
var direction: Vector2	
func PewPew(target, origin):
	global_position = origin
	direction = (target - origin).normalized()
	
func reload():
	magSize = 25

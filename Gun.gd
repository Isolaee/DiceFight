extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	look_at_mouse()
	
	if Input.is_action_pressed("fire"):
		shoot()

func look_at_mouse():
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)

	
@export var Bullet : PackedScene

func shoot():
	var b = Bullet.instantiate()
	get_node("/root/World").add_child(b)
	b.add_to_group("Bullets")
	b.global_position = $GunSprite/Barrel.global_position
	

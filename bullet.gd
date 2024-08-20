extends Area2D
	
var speed = 1000
var direction: Vector2

func _ready() -> void:
	self.connect("body_entered", _when_body_hit)
	look_at_mouse()

func _physics_process(delta):
	position += transform.x * speed * delta

func _when_body_hit(_body):
	queue_free()

func look_at_mouse():
	var mouse = get_global_mouse_position()
	look_at(mouse)
	

extends KinematicBody2D


# Declare member variables here. Example
var gravity : int = 3200
var vel : Vector2 = Vector2()

var health : int = 3
const Bit = preload("res://playerItems/bit.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	vel = move_and_slide(vel, Vector2.UP)
	
	vel.y += gravity * delta

func damage():
	if health > 0:
		health -= 1
		if health <= 0:
			var rng = RandomNumberGenerator.new()
			print(self.get_canvas_transform().get_origin())
			rng.randomize()
			for i in 4:
				var Instance = Bit.instance()
				get_parent().add_child(Instance)
				Instance.position.x = self.position.x + rng.randf_range(-150, 150)
				Instance.position.y = self.position.y + rng.randf_range(-150, 150)
			queue_free()


extends KinematicBody2D


# Declare member variables here. Example
var gravity : int = 3200
var vel : Vector2 = Vector2()

var health : int = 3
var lootDistance : int = 120
var bitDrop = 4
const Bit = preload("res://playerItems/bit.tscn")

var followDistance = 400
var verticalSightReductionFactor = 5

var stoppingDistance = 80
var followSpeed = 250
var xDampening = 1.05

var attackInterval : float = 2
var attackTimer : float = 0
var attackBoost : int  = 65
var telegraphTime : float  = 0.3

var damage = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process (delta):
	vel.y += gravity * delta
	vel.x = vel.x / xDampening
	
	var player = get_tree().get_root().get_child(0).get_node("Player")
	var vectorToPlayer = player.global_position - self.global_position
	vectorToPlayer.y = vectorToPlayer.y * verticalSightReductionFactor
	
	if player != null:
		if vectorToPlayer.length() < followDistance:
			if vectorToPlayer.length() > stoppingDistance:
				vel.x += (vectorToPlayer.normalized().x * delta * followSpeed)
			else:
				attackTimer += delta
				
				if (attackTimer >= (attackInterval - telegraphTime)):
					self.get_child(0).color = Color.from_hsv(0, 0, 1)
				else:
					var child = self.get_child(0)
					self.get_child(0).color = Color.from_hsv(0, 0, 0.25)
				
				if attackTimer >= attackInterval:
					attackTimer = 0
					self.get_child(0).color = Color.from_hsv(0, 0, 0.25)
					print("attacking")
					vel += (vectorToPlayer.normalized() * delta * followSpeed * attackBoost)
	
	vel = move_and_slide(vel, Vector2.UP)
	for i in get_slide_count():
		var colided = get_slide_collision(i).collider
		if colided.name == "Player":
			colided.takeDamage(damage)

func damage():
	if health > 0:
		health -= 1
		if health <= 0:
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			for i in bitDrop:
				var Instance = Bit.instance()
				get_parent().add_child(Instance)
				Instance.position.x = self.position.x + rng.randf_range(-lootDistance, lootDistance)
				Instance.position.y = self.position.y + rng.randf_range(-lootDistance, lootDistance)
			queue_free()


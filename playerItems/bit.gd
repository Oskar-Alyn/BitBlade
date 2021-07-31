extends Node

onready var globals = get_node("/root/Globals")

var rng = RandomNumberGenerator.new()

var blinkRate = rng.randf_range(0.6, 3.5)
var followDistance = 100
var followSpeed = 10
var connected = false
var connectedOffset = Vector2()
var connectedTo = null

var bitPosition = 1;

var blinkTimer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_child(0).color = globals.playerFactionColor
	rng.randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	blink_logic(delta)

func _physics_process(delta):
	var player = get_tree().get_root().get_child(1).get_node("Player")
	var vectorToPlayer = player.global_position - self.global_position
	
	if !connected and player != null:
		if (vectorToPlayer.length() < followDistance):
			connected = true
			connectedTo = player
			player.totalBits += 1
			bitPosition = player.totalBits
	
	if connected:
		var bladeOffset = Vector2()
		
		if Input.is_action_pressed("attack"):
			bladeOffset.y = -1 * bitPosition
			if player.isFacingRight:
				bladeOffset.x += (8 * bitPosition)
			else:
				bladeOffset.x += (-8 * bitPosition)
		else:
			bladeOffset.y += (3 * bitPosition)
			if player.isFacingRight:
				bladeOffset.x += (-7 * bitPosition)
			else:
				bladeOffset.x += (7 * bitPosition)
		
		var steer = bladeOffset + vectorToPlayer
		
		self.global_position += (steer * delta * followSpeed)

func blink_logic(delta):
	var child = self.get_child(0)
	blinkTimer += delta*4
	var offset = fmod(self.position.x - self.position.y, 5000) / 300
	if blinkTimer + offset > blinkRate:
		blinkRate = rng.randf_range(0.6, 3.5)
		blinkTimer -= 3;
		if child.color == globals.playerFactionColor:
			blinkRate = rng.randf_range(0.6, 1.5)
			child.color = Color(10, 10, 10)
		else:
			blinkRate = rng.randf_range(2, 4.5)
			child.color = globals.playerFactionColor

func _on_Bit_body_entered(body):
	if connected:
		if body.is_in_group("Enemy"):
			connectedTo.totalBits -= 1
			body.damage()
			queue_free()

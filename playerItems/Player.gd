extends KinematicBody2D


# Declare member variables here. Examples:
var speed : int = 500
var jumpForce : int = 70
var groundFactor : float = 8
var gravity : int = 2800

var isFacingRight : bool = true

var maxJumpTime : float = 0.15
var currentJumpTime = maxJumpTime
var maxCoyote : float = 5
var coyote : float = maxCoyote

var vel : Vector2 = Vector2()
var grounded : bool = false

var totalBits = 0
var bits = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process (delta):
	vel.x = 0
	if Input.is_action_pressed("move_left"):
		vel.x -= speed
		isFacingRight = false
	if Input.is_action_pressed("move_right"):
		vel.x += speed
		isFacingRight = true
	
	vel.y += gravity * delta
	
	if is_on_floor():
		currentJumpTime = maxJumpTime;
		coyote = maxCoyote
	else:
		currentJumpTime -= delta
		coyote -= delta
	
	
	if Input.is_action_pressed("jump") and currentJumpTime > 0:
		vel.y -= jumpForce
		if is_on_floor() or coyote > 0:
			vel.y = -1 * jumpForce * groundFactor
			coyote = 0
	
	if (self.position.y > 1500):
		die()
		
	# actual motion
	vel = move_and_slide(vel, Vector2.UP)

func takeDamage(damage):
	die()

func die():
	self.position.y = 0
	self.position.x = 0
	print("Temporary death mechanic")
	

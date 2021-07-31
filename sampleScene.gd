extends Node

const Bit = preload("res://playerItems/bit.tscn")
const MonsterRoom = preload("res://rooms/MonsterRoom.tscn")
const PlatformRoom = preload("res://rooms/PlatformRoom.tscn")
const Rubble = preload("res://rooms/Rubble.tscn")
const TreasureRoom = preload("res://rooms/TreasureRoom.tscn")

var size = 7

# Called when the node enters the scene tree for the first time.
func _ready():
	# configure random
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	# build rooms
	for x in size:
		for y in size:
			var Instance
			match rng.randi_range(0, 5):
				0, 1:
					Instance = MonsterRoom.instance()
				2, 3:
					Instance = PlatformRoom.instance()
				4:
					Instance = Rubble.instance()
				5:
					Instance = TreasureRoom.instance()
			self.add_child(Instance)
			Instance.position.x = 2*496*(x-floor(size/2))
			Instance.position.y = 2*304*(y-floor(size/2)-1)
	
	for i in (size*size*0.5):
		var Instance = Bit.instance()
		self.add_child(Instance)
		Instance.position.x = rng.randf_range(-496 * size, 496 * size)
		Instance.position.y = rng.randf_range(-304 * size, 304 * size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

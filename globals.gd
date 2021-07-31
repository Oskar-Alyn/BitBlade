extends Node

var rng = RandomNumberGenerator.new()
var noPurpose = rng.randomize()

#var playerFactionColor = Color.from_hsv(0.4, 0.8, 0.8)
#var enemyFactionColor = Color.from_hsv(0.95, 0.8, 0.8)

var playerFactionColor = Color.from_hsv(rng.randf_range(0, 1), 0.8, 0.8)
var enemyFactionColor = Color.from_hsv(rng.randf_range(0, 1), 0.8, 0.8)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

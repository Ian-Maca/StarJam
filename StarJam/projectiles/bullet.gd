extends Area2D

const SPEED = 1000
const RANGE = 1200

var travelled_distance = 0

#based on its rotation, determines a direction to move
## essentially gets self forward direction
var direction

#Returns first root parent node of 'node' with name 'node_name'
func get_root_node_by_name(node : Node, node_name):
	var root = node
	while root.get_parent() != null:
		root = root.get_parent()
		if root.name == node_name:
			break
	return root

#when bullet first spawned in projectileSpawn sets bullet direction
#based on its rotation (lines up with gun rotation)
func _ready():
	direction = Vector2.RIGHT.rotated(global_rotation)
	self.reparent(get_root_node_by_name(self, 'Game').get_node("projectiles"), true)
	
#move bullet along set direction
#despawns if bullet has travelled too far
func _physics_process(delta):
	position += direction * delta * SPEED
	travelled_distance += delta * SPEED
	
	if travelled_distance >= RANGE:
		queue_free()

#check for collision with an enemy
#if there is one, kill projectile and 
#call take_damage on the enemy that was hit
func _on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()

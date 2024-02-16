extends Area2D

const BULLET = preload("res://projectiles/bullet.tscn")

var bullet_dmg = 1
var bullet_pierce = 1

func set_fire_timer(rate):
	$Timer.wait_time = rate

#update gun orientation to look at closest enemy
func _physics_process(_delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy : CharacterBody2D = enemies_in_range.front()
		#look at closest enemy every frame
		look_at(target_enemy.global_position)

#timer to call shoot()
func _on_timer_timeout():
	shoot()

#sets orientation of the gun and its children
func shoot():
	#orient gun each shot to flip gun to correct scale
	var gun_oreintation = get_parent().global_position.x - %bulletSpawn.global_position.x
	if(gun_oreintation >= 0):
		self.scale.y = -1
	else:
		self.scale.y = 1
	add_bullet()

#adds BULLET instance to bulletSpawn
func add_bullet():
	var new_bullet = BULLET.instantiate()
	new_bullet.DAMAGE = bullet_dmg
	new_bullet.pierce = bullet_pierce
	%bulletSpawn.add_child(new_bullet)


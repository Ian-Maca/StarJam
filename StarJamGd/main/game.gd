extends Node2D

var mainLevelPacked: PackedScene = preload("res://UI/deathmenu.tscn")
var mobLevelPacked: PackedScene = preload("res://enemy/slime.tscn")

var mobCount : int = 0
var mobHealth = 3
var mobXpReward = 40
var mobSpeed = 300

func spawn_mob():
	var mob = mobLevelPacked.instantiate()
	%PathFollow2D.progress_ratio = randf()
	mob.global_position = %PathFollow2D.global_position
	mob.health = mobHealth
	mob.exp_reward = mobXpReward
	mob.mob_speed = mobSpeed
	$enemies.add_child(mob)

func _on_enemy_spawn_timer_timeout():
	spawn_mob()
	mobCount += 1
	
	#PASSIVE MOB STAT INCREASE
	#EVERY __ AMOUNT OF MOBS 
	if(mobCount % 50 == 0):
		$EnemySpawnTimer.wait_time *= 0.98
		mobHealth += 3
		if(mobSpeed < 1000):
			mobSpeed *= 1.2
			print('Mob speed: ', mobSpeed)
		mobXpReward *= 2
		
		
func player_death_anim():
	pass
	
func _on_player_health_depleted():
	player_death_anim()
	get_tree().change_scene_to_packed(mainLevelPacked)

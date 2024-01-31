extends Node2D

var mainLevelPacked : PackedScene = preload("res://UI/deathmenu.tscn")

func spawn_mob():
	var mob = preload("res://enemy/slime.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	mob.global_position = %PathFollow2D.global_position
	add_child(mob)

func _on_enemy_spawn_timer_timeout():
	spawn_mob()

func player_death_anim():
	pass
	
func _on_player_health_depleted():
	player_death_anim()
	get_tree().change_scene_to_packed(mainLevelPacked)

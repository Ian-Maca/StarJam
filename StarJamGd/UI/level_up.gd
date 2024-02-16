extends Control

var star_preload = preload("res://UI/Star.tscn")
var rng = RandomNumberGenerator.new()
var starCount : int = 0

var star_speed = Vector2.LEFT * 1800

func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(self.position.x - 400, -500), 1.5)
	#case open anim
	$AnimationPlayer.play("open")
	await $AnimationPlayer.animation_finished
	
	#case sparkle idle anim
	$AnimationPlayer.play("sparkle")
	%StarSpawner.start()

func _on_star_spawner_timeout():
	star_generate()


func star_generate():
	if starCount <= 14:
		var star = star_preload.instantiate()
		star.tier = rng.randi_range(0, 2)
		star.speed = star_speed
		#stop last star halfway
		if starCount == 14:
			star.stop_half = true
			
		%starSpawn.add_child(star)
		star_speed *= 0.90
		%StarSpawner.wait_time += 0.05
		starCount += 1
	else:
		%StarSpawner.stop()
		
func _on_star_star_recieved():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(self.position.x + 400, + 500), 1.5)

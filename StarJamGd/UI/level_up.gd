extends Control

var star_preload = preload("res://UI/Star.tscn")
var rng = RandomNumberGenerator.new()
var starCount : int = 0

var speed = Vector2.LEFT * 1800

func _ready():
	$AnimationPlayer.play("open")
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play("sparkle")
	%StarSpawner.start()

func _on_star_spawner_timeout():
	star_generate()

func star_generate():
	if starCount <= 14:
		var star = star_preload.instantiate()
		star.tier = rng.randi_range(0, 2)
		star.speed = speed
		#stop last star halfway
		if starCount == 14:
			star.stop_half = true
		%starSpawn.add_child(star)
		speed *= 0.90
		%StarSpawner.wait_time += 0.05
		starCount += 1
	else:
		%StarSpawner.stop()

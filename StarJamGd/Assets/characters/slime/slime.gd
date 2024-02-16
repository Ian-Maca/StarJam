extends Node2D

func play_walk():
	%AnimationPlayer.speed_scale = 1
	%AnimationPlayer.play("idle")
	$rockDude_idle.visible = true
	$rockDude_hurt.visible = false
	
func play_hurt():
	%AnimationPlayer.play("hurt")
	%AnimationPlayer.speed_scale = 2
	#%AnimationPlayer.queue("idle")
	$rockDude_idle.visible = false
	$rockDude_hurt.visible = true
	await %AnimationPlayer.animation_finished
	play_walk()

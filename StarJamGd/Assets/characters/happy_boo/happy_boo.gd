extends Node2D

func play_idle_animation():
	#change visibility of track, and plays currently
	#visible track!
	%AnimationPlayer.play("idle")
	%starguy_idle.visible = true
	%starguy_run.visible = false
func play_walk_animation():
	%AnimationPlayer.play("walk")
	%starguy_idle.visible = false
	%starguy_run.visible = true
#func play_death_animation():
	#%AnimationPlayer.play("death")

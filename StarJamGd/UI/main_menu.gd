extends Control

const main_scene: PackedScene = preload("res://main/game.tscn")

func _on_button_pressed():
	get_tree().change_scene_to_packed(main_scene)


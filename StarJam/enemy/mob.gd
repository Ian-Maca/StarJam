extends CharacterBody2D

const SMOKE_SCENE = preload("res://Assets/smoke_explosion/smoke_explosion.tscn")

var health = 3

@onready var player = get_node("/root/Game/Player")

var mob_speed = 300

func _ready():
	%slime.play_walk()

#gets directioon to player and moves based on mob_speed
func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * mob_speed
	move_and_slide()

#called when projectile hits mob
#decreases mob health and plays hurt animation
#if mob health is zero kill mob after playing smoke anim
func take_damage():
	health -= 1
	
	%slime.play_hurt()
	if health == 0:
		queue_free()
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position 

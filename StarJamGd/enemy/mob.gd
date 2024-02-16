extends CharacterBody2D

const SMOKE_SCENE = preload("res://Assets/smoke_explosion/smoke_explosion.tscn")

var health

var exp_reward : int

@onready var player = get_node("/root/Game/Player")

var mob_speed

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
func take_damage(projectile):
	health -= projectile.DAMAGE
	
	%slime.play_hurt()
	
	#ENEMY DEAD, give xp reward and play smoke animn while killing self
	if health <= 0:
		# GIVE player MOB xp
		#player.xp += self.exp_reward
		player.give_xp(self.exp_reward)
		
		if player.xp >= player.expGate:
			player.level_up()
			print(player.level)
		queue_free()
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position 

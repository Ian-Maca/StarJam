extends CharacterBody2D

signal health_depleted

var speed = 600

var health : float = 100.0

const DAMAGE_RATE = 5.0

func _physics_process(delta):
	var direction = Input.get_vector("left", "right","up", "down")
	velocity = direction * speed
	move_and_slide()
	if velocity.length() == 0:
		%HappyBoo.play_idle_animation()
	else:
		%HappyBoo.play_walk_animation()
		
	#check if there are enemies in the hurtbox, for each enemy
	# in it, decrease health perframe using damage rate and delta
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%HealthBar.value = health
		if health <= 0.0:
			health_depleted.emit()
			

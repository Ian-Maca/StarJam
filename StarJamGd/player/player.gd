extends CharacterBody2D

var level_up_preload = preload("res://UI/level_up.tscn")

signal health_depleted

var speed = 600
var health : float = 100.0

var level : int = 1
var expGate : int = 1000
var xp : int = 100

var gunFireRate = 0.5

const DAMAGE_RATE = 10.0

func _ready():
	#update UI health to char health
	$MainUI.health = health

func _input(event):
	if(event.is_action_pressed("debug")):
		#health_depleted.emit()
		#level_up()
		pass

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
		$MainUI.health = health
		if health <= 0.0:
			health_depleted.emit()
			
			
func level_up():
	run_lvlui_event()
	#get_tree().paused = true

func run_lvlui_event():
	var level_up_scene = level_up_preload.instantiate()
	self.add_child(level_up_scene)
	
func recieve_star(tier):
	if tier == 0:
		#SPEED
		speed *= 1.1
	elif tier == 1:
		#DAMAGE
		%Gun.bullet_dmg += 2
		gunFireRate *= 0.94
		%Gun.set_fire_rate(gunFireRate)
	elif tier == 2:
		#HEALTH
		health += 50
	
	
	

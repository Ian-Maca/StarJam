extends CharacterBody2D

var level_up_preload = preload("res://UI/level_up.tscn")
signal health_depleted

const DAMAGE_RATE = 10.0    #how much enemies hurt player

var speed = 600             #movement speed
var health : float = 100    #health
var gunFireTimer = 0.5      #timer that determines fire rate

var level : int = 1         #current level 
var expGate : float = 1000    #amount needed for level up
var xp : int = 100          #current xp

func _ready():
	#update UI health to char health
	$MainUI.health = health
	$MainUI.damage = %Gun.bullet_dmg
	$MainUI.max_health = health
	$MainUI.xp = xp
	$MainUI.xp_ceiling = expGate
	$MainUI.update_xpbar(xp, expGate)

func _input(event):
	if(event.is_action_pressed("debug")):
		#health_depleted.emit()
		level_up()
	elif(event.is_action_pressed("zoom out")):
		if (%Camera2D.zoom > Vector2(0.25, 0.25)):
			%Camera2D.zoom -= Vector2(0.05, 0.05) 
		print(%Camera2D.zoom)
	elif(event.is_action_pressed("zoom in")):
		if (%Camera2D.zoom < Vector2(0.7, 0.7)):
			%Camera2D.zoom += Vector2(0.05, 0.05)

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
	await run_lvlui_event()
	#get_tree().paused = true

func run_lvlui_event():
	level+=1
	expGate *= 1.6
	$MainUI.xp_ceiling = expGate
	$MainUI.update_xpbar(xp, expGate)
	var level_up_scene = level_up_preload.instantiate()
	self.call_deferred("add_child", level_up_scene)
	
func recieve_star(tier):
	if tier == 0:
		#SPEED and PIERCE
		if(speed < 1500):
			speed *= 1.3
		%Gun.bullet_pierce += 1
		
	elif tier == 1:
		#DAMAGE and FIRE RATE
		%Gun.bullet_dmg += 2
		$MainUI.damage = %Gun.bullet_dmg
		
		gunFireTimer *= 0.90
		%Gun.set_fire_timer(gunFireTimer)
	elif tier == 2:
		#HEALTH
		health += 50
		$MainUI.health = health 
		if $MainUI.max_health < health:
			$MainUI.max_health = health

func give_xp(m_xp):
	xp += m_xp
	$MainUI.xp = xp
	

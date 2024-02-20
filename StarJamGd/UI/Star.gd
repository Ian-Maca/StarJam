extends CharacterBody2D

var tier : int
var speed = Vector2.LEFT * 1800
var stop_half : bool = false

signal star_recieved

func _ready():
	if(tier == 0):
		#SPEED
		$star.self_modulate = Color.LIGHT_BLUE 
	elif(tier == 1):
		#DAMAGE
		$star.self_modulate = Color.SADDLE_BROWN
	elif(tier == 2):
		#HEALTH
		$star.self_modulate = Color.GOLD
		
var stopper : bool = false

func _process(_delta):
	if(self.position.x <= -100 and stop_half):
		#Stop last star at halfway point
		if(!stopper):
			StarOpen()
			stopper = true
	
	if(self.position.x <= -200):
		queue_free()
		
	velocity = speed
	move_and_slide()


#Animates star opening and calls recieve_star() on the player
func StarOpen():
	velocity = Vector2.ZERO
	speed = Vector2.ZERO
	
	var player = get_node("/root/Game/Player")
	
	#Move toward player animation
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	
	tween.tween_property(self, "scale",Vector2(0, 0) , 1.5)
	tween2.tween_property(self, "rotation", 3, 2)
	
	await tween.finished
	await tween2.finished
	
	player.recieve_star(tier)
	get_parent().get_parent().queue_free()
	
	
	



extends CharacterBody2D

var tier : int
var speed
var stop_half : bool = false

func _ready():
	velocity = Vector2.ZERO
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
	if(self.position.x <= -200 and stop_half):
		#Stop last star at halfway point
		if(!stopper):
			StarOpen()
			stopper = true
	
	if(self.position.x <= -420):
		queue_free()
	velocity = speed
	move_and_slide()

func StarOpen():
	velocity = Vector2.ZERO
	speed = Vector2.ZERO
	
	var player = get_node("/root/Game/Player")
	
	#Move toward player animation
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale",Vector2(1.2, 1.2) , 1.5)
	$anim.play("spin")
	tween.tween_property(self, "position", Vector2(self.position.x + 400, 300), 1)
	tween.tween_property(self, "scale", Vector2(0.001, 0.001), 1.5)
	await tween.finished
	
	#Destroy grandpaent after giving star to the player
	player.recieve_star(tier)
	get_parent().get_parent().queue_free()
	
	



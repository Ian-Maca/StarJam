extends Control

var health : float 

var max_health : float

var damage
var xp_ceiling
var xp

func update_xpbar(lmin, lmax):
	%XpProgressBar.min_value = lmin
	%XpProgressBar.max_value = lmax 

func _process(_delta):
	%ProgressBar.value = health
	%ProgressBar.max_value = max_health
	%health.text = str(round(health))
	%damage.text = str(damage)
	%XpProgressBar.value = xp
	

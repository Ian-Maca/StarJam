extends CanvasLayer

var window_size

func _ready():
	window_size = get_viewport().size
	
func _process(_delta):
	window_size = get_viewport().size

extends Node2D

func _ready():
	position.y = 149
	GlobalManager.main_menu = true
	
func _process(delta):
	if GlobalManager.main_menu == false:
		self.hide()
		

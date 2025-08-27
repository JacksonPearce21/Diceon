extends Node2D

func _ready():
	GlobalManager.game_over = false
	
func _process(delta):
	if GlobalManager.game_over == true:
		self.show()
		

func _on_close_pressed() -> void:
	get_tree().quit()

	

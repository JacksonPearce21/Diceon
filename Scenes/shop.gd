extends Node2D


func _ready():
	GlobalManager.shopping = true
	pass




func _on_next_round_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_game.tscn")
	GlobalManager.shopping = false
	GlobalManager.next_round()

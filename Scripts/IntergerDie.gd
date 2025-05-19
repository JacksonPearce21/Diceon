extends Node3D

var faces = [1,2,3,4,5,6,7,8,9,10]
var current_value = 1

func roll():
	current_value = faces[randi() % faces.size()]
	print("Integer Die rolled: ", current_value)

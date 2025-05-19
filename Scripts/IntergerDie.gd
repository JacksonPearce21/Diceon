extends Node3D

@export var sides = [1,2,3,4,5,6,7,8,9,10]
var current_face_value = 1

func roll():
	current_face_value = sides.pick_random()
	tween_to_face(current_face_value)

func tween_to_face(value):
	print("Rolling to face with value:", value)

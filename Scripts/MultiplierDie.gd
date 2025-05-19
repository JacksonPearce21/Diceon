extends Node3D

@export var sides = [1.0, 1.5, 2, 2.5, 3, 3.5]
var current_face_value = 1.0

func roll():
	current_face_value = sides.pick_random()
	tween_to_face(current_face_value)

func tween_to_face(value):
	print("Rolling to face with value:", value)

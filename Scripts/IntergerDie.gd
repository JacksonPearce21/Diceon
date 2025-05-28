extends Node3D

@export var sides := {
	1: {"rotation": Vector3(0, 0, 0)},
	2: {"rotation": Vector3(0, deg_to_rad(90), 0)},
	3: {"rotation": Vector3(0, deg_to_rad(180), 0)},
	4: {"rotation": Vector3(0, deg_to_rad(270), 0)},
	5: {"rotation": Vector3(deg_to_rad(90), 0, 0)},
	6: {"rotation": Vector3(deg_to_rad(-90), 0, 0)},
	7: {"rotation": Vector3(deg_to_rad(45), deg_to_rad(45), 0)},
	8: {"rotation": Vector3(deg_to_rad(-45), deg_to_rad(90), 0)},
	9: {"rotation": Vector3(deg_to_rad(135), 0, 0)},
	10: {"rotation": Vector3(deg_to_rad(180), deg_to_rad(180), 0)},
}

var current_face_value = 1

func roll():
	current_face_value = sides.keys().pick_random()
	tween_to_face(current_face_value)

func tween_to_face(value: int):
	var face_data = sides.get(value)
	if face_data:
		print("Rolling INT to face:", value)
		var rotation = face_data["rotation"]
		var tween = create_tween()
		tween.tween_property(self, "rotation", rotation, 0.8).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

extends Node3D

@export var sides := {
	1: {"rotation": Vector3(-65, -2, -35)},
	2: {"rotation": Vector3(62, 177, -3)},
	3: {"rotation": Vector3(-60, 0, 37)},
	4: {"rotation": Vector3(61, 179, -145)},
	5: {"rotation": Vector3(-60, 2, 177)},
	6: {"rotation": Vector3(60, 179, -75)},
	7: {"rotation": Vector3(-60, 1, -109)},
	8: {"rotation": Vector3(62, 179, 72)},
	9: {"rotation": Vector3(-60, -1, 108)},
	10: {"rotation": Vector3(60, 177, 140)},
}

var current_face_value = 1
var tween: Tween

func _ready() -> void:
	tween_to_face(current_face_value)
	
	
func roll():
	var random_rot = Vector3(
		randf_range(200, 400),
		randf_range(200, 400),
		randf_range(200, 400)
	)
	var random_rot_end = Vector3(
		randf_range(100, 200),
		randf_range(100, 200),
		randf_range(100, 200)
	)
	tween = create_tween()
	tween.tween_property(self, "rotation_degrees", random_rot, 0.7)
	tween.tween_property(self, "rotation_degrees", random_rot_end, 0.3)
	await get_tree().create_timer(1.0).timeout
	current_face_value = sides.keys().pick_random()
	tween_to_face(current_face_value)

func tween_to_face(value: int):
	var face_data = sides.get(value)
	if face_data:
		print("Rolling INT to face:", value)
		var rotation = face_data["rotation"]
		var tween = create_tween()
		tween.tween_property(self, "rotation_degrees", rotation, 0.8).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

extends Node3D

@export var sides := {
	1: {"rotation": Vector3(0, -90, -90)},
	2: {"rotation": Vector3(0, 0, 0)},
	3: {"rotation": Vector3(0, -90, 0)},
	4: {"rotation": Vector3(0, 90, 0)},
	5: {"rotation": Vector3(0, 180, 0)},
	6: {"rotation": Vector3(0, -90, 90)},
}

var current_face_value = sides.keys().pick_random()
var tween: Tween
var tween_time = 0

func _ready() -> void:
	tween_to_face(current_face_value)
	tween_time = 0.8

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
	tween.tween_property(
		self, "rotation_degrees", random_rot, 0.7).set_trans(
			Tween.TRANS_SINE)
	tween.tween_property(
		self, "rotation_degrees", random_rot_end, 0.3)
	await get_tree().create_timer(1.0).timeout
	current_face_value = sides.keys().pick_random()
	tween_to_face(current_face_value)

func tween_to_face(value: int):
	var face_data = sides.get(value)
	if face_data:
		print("Rolling MULT to face:", value)
		var rotation = face_data["rotation"]
		var tween_rotation = create_tween()
		tween_rotation.tween_property(
			self, "rotation_degrees", rotation, tween_time).set_ease(
				Tween.EASE_OUT)

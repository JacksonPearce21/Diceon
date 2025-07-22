extends Panel

@onready var description_box = $Discription_Box

func _ready():
	add_to_group("Card")
	description_box.visible = false

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if get_rect().has_point(get_global_mouse_position()):
			CardManager.select_card(self)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		var hovered = get_viewport().gui_get_hovered_control()
		if hovered == null or not hovered.is_in_group("Card"):
			if CardManager.current_card:
				CardManager.current_card.hide_description()
				CardManager.current_card = null

func show_description():
	description_box.visible = true

func hide_description():
	description_box.visible = false

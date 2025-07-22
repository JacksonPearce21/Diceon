extends Node2D

@onready var description_box = $Discription_Box
@onready var card = $AceOfSpades2

func _ready():
	description_box.visable = false

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if card.has_point(get_global_mouse_position()):
			CardManager.select_card(self)

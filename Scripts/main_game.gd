extends Node2D

@onready var int_dice = $CanvasLayer/SubViewportContainer/IntViewport/interger_die
@onready var mult_dice = $CanvasLayer/SubViewportContainer/MultViewport/multiplier_die
@onready var score_label = $CanvasLayer/ScoreLabel

func _ready():
	roll_all_dice()
	pass

func roll_all_dice():
	int_dice.roll()
	mult_dice.roll()
	await get_tree().create_timer(1.5).timeout
	calculate_score()

func calculate_score():
	var base = int_dice.current_face_value
	var mult = mult_dice.current_face_value
	var total = base * mult
	score_label.text = "Score: %.1f" % total


func _on_button_pressed():
	roll_all_dice()

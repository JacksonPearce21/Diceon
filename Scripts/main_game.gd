extends Node2D

@onready var int_dice = $CanvasLayer/SubViewportContainer/IntViewport/interger_die
@onready var mult_dice = $CanvasLayer/SubViewportContainer2/MultViewport/multiplier_die
@onready var added_score_label = $CanvasLayer/Added_score
@onready var score_label = $Control/SideBar/Score
@onready var rolls_label = $Control/SideBar/Rolls
@onready var required_score_label = $Control/SideBar/Required_score
@onready var round_num_label = $Control/SideBar/Round_num
var round_score = 0

func _ready():
	round_num_label.text = str(GlobalManager.current_round)
	rolls_label.text = str(GlobalManager.dice_rolls)
	required_score_label = str(GlobalManager.score_needed)
	score_label.text = str(round_score)
	pass

func roll_all_dice():
	GlobalManager.decrease_roll()
	rolls_label.text = str(GlobalManager.dice_rolls)
	int_dice.roll()
	mult_dice.roll()
	await get_tree().create_timer(1.9).timeout
	calculate_score()

func calculate_score():
	var base = int_dice.current_face_value
	var mult = mult_dice.current_face_value
	var total = base * mult
	added_score_label.text = "+ %.0f" % total
	round_score += total
	score_label.text = str(round_score)


func _on_button_pressed():
	roll_all_dice()

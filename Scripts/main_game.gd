extends Node2D

@onready var int_dice = $CanvasLayer/SubViewportContainer/IntViewport/interger_die
@onready var mult_dice = $CanvasLayer/SubViewportContainer2/MultViewport/multiplier_die
@onready var score_label = $CanvasLayer/Added_score
@onready var score =$Control/SideBar/Score
@onready var rolls =$Control/SideBar/Rolls
@onready var required_score =$Control/SideBar/Required_score




func _ready():
	rolls.text = str(GlobalManager.dice_rolls)
	pass

func roll_all_dice():
	GlobalManager.dice_rolls =- 1
	rolls.text = str(GlobalManager.dice_rolls)
	int_dice.roll()
	mult_dice.roll()
	await get_tree().create_timer(1.9).timeout
	calculate_score()

func calculate_score():
	var base = int_dice.current_face_value
	var mult = mult_dice.current_face_value
	var total = base * mult
	score_label.text = "+ %.0f" % total


func _on_button_pressed():
	GlobalManager.dice_rolls -= 1
	rolls.text = str(GlobalManager.dice_rolls)
	roll_all_dice()
	
	

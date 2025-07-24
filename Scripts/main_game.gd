extends Node2D

@onready var int_dice = $CanvasLayer/SubViewportContainer/IntViewport/interger_die
@onready var mult_dice = $CanvasLayer/SubViewportContainer2/MultViewport/multiplier_die
@onready var added_score_label = $CanvasLayer/Added_score
@onready var score_label = $SideBar/SideBar/Score
@onready var rolls_label = $SideBar/SideBar/Rolls
@onready var required_score_label = $SideBar/SideBar/Required_score
@onready var round_num_label = $SideBar/SideBar/Round_num
@onready var EOR_popup = $CanvasLayer/EOR_popup
@onready var money_label = $SideBar/SideBar/Money
var round_score = 0

func _ready():
	start_round()
	pass

func start_round():
	GlobalManager.current_round += 1
	round_score = 0
	EOR_popup.hide()
	update_labels()

func update_labels():
	round_num_label.text = str(GlobalManager.current_round)
	rolls_label.text = str(GlobalManager.dice_rolls)
	required_score_label.text = str(GlobalManager.score_needed)
	score_label.text = str(round_score)
	money_label.text = "$" + str(GlobalManager.money)

func roll_all_dice():
	GlobalManager.decrease_roll()
	update_labels()
	int_dice.roll()
	mult_dice.roll()
	await get_tree().create_timer(1.9).timeout
	calculate_score()
	await get_tree().create_timer(0.5).timeout
	check_game_status()
	$"CanvasLayer/Roll Dice".disabled = false

func calculate_score():
	var base = int_dice.current_face_value
	var mult = mult_dice.current_face_value
	var total = base * mult
	added_score_label.text = "+ " + str(total)
	added_score_ani()
	round_score += total
	update_labels()
	
func added_score_ani():
	added_score_label.show()
	await get_tree().create_timer(0.9).timeout
	added_score_label.hide()

func check_game_status():
	if GlobalManager.score_needed <= round_score:
		print("You Win")
		GlobalManager.round_status = true
		pass
	if GlobalManager.score_needed > round_score:
		if GlobalManager.dice_rolls == 0:
			game_over()

func game_over():
	print("game_over")
	get_tree().quit()

func _on_button_pressed():
	$"CanvasLayer/Roll Dice".disabled = true
	roll_all_dice()

func _on_click_catcher_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		get_tree().call_group("cards", "hide_description")	

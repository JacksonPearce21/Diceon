extends Node2D


@onready var int_label = $CanvasLayer/int_label
@onready var mult_label = $CanvasLayer/mult_label
@onready var int_dice = $CanvasLayer/SubViewportContainer/IntViewport/interger_die
@onready var mult_dice = $CanvasLayer/SubViewportContainer2/MultViewport/multiplier_die
@onready var roll_dice = $"Roll Dice"
@onready var added_score_label = $CanvasLayer/Added_score
@onready var score_label = $SideBar/SideBar/Score
@onready var rolls_label = $SideBar/SideBar/Rolls
@onready var required_score_label = $SideBar/SideBar/Required_score
@onready var round_num_label = $SideBar/SideBar/Round_num
@onready var EOR_popup = $EOR_popup
@onready var money_label = $SideBar/SideBar/Money
var base
var mult

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
	CardEffects.reset_variables()
	CardEffects.hide_labels()

func roll_all_dice():
	GlobalManager.decrease_roll()
	update_labels()
	int_dice.roll()
	mult_dice.roll()
	await get_tree().create_timer(1.9).timeout
	calculate_score()

func calculate_score():
	base = int_dice.current_face_value
	int_label.text = "+ " + str(base)
	mult = mult_dice.current_face_value
	mult_label.text = "+ " + str(mult)
	int_label.show()
	mult_label.show()
	check_for_cards()

func check_for_cards():
	if CardManager.current_cards.has(preload("res://Scenes/dealers_cut.tscn")):
		CardEffects.dealers_cut(base, mult)
		if CardEffects.dealers_int != 0:
			await get_tree().create_timer(1).timeout
			base = CardEffects.dealers_int
			int_label.text = "+ " + str(base)
		elif CardEffects.dealers_mult != 0:
			await get_tree().create_timer(1).timeout
			mult = CardEffects.dealers_mult
			mult_label.text = "+ " + str(mult)
	
	if CardManager.current_cards.has(preload("res://Scenes/high_roller_card.tscn")):
		CardEffects.high_roller(base)
		if CardEffects.high_roller_int != 0:
			await get_tree().create_timer(1).timeout
			base = CardEffects.high_roller_int
			int_label.text = "+ " + str(base)
	final_calc()
	
func final_calc():
	var total = base * mult
	added_score_label.text = "+ " + str(total)
	added_score_ani()
	round_score += total
	update_labels()
	await get_tree().create_timer(1).timeout
	check_game_status()
	roll_dice.disabled = false
	

func added_score_ani():
	added_score_label.show()
	await get_tree().create_timer(0.9).timeout
	int_label.hide()
	mult_label.hide()
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
	roll_dice.disabled = true
	roll_all_dice()

func _on_click_catcher_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		get_tree().call_group("cards", "hide_description")	

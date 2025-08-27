extends Node2D


@onready var int_label = $CanvasLayer/Panel/int_label
@onready var mult_label = $CanvasLayer/Panel2/mult_label
@onready var int_dice = $CanvasLayer/SubViewportContainer/IntViewport/interger_die
@onready var mult_dice = $CanvasLayer/SubViewportContainer2/MultViewport/multiplier_die
@onready var roll_dice = $"Roll Dice"
@onready var added_score_label = $CanvasLayer/Panel3/Added_score
@onready var score_label = $SideBar/SideBar/Panel2/Panel/Score
@onready var rolls_label = $SideBar/SideBar/Panel5/Panel/Rolls
@onready var required_score_label = $SideBar/SideBar/Panel/Panel/Required_score
@onready var round_num_label = $SideBar/SideBar/Panel4/Panel/Round_num
@onready var EOR_popup = $EOR_popup
@onready var money_label = $SideBar/SideBar/Panel3/Panel/Money
var duration = 0.85
var base
var mult

var round_score = 0

func _ready():
	$"Roll Dice".hide()
	GlobalManager.current_round += 1
	EOR_popup.hide()
	$Shop.hide()
	$"Main Menu".show()
	$"Game Over".hide()
	update_labels()
	pass

func _process(delta):
	if GlobalManager.out_of_shop == true:
		$"Roll Dice".show()
		start_round()
		GlobalManager.out_of_shop = false
	
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
	int_label.text = "" + str(base)
	mult = mult_dice.current_face_value
	mult_label.text = "" + str(mult)
	int_label.show()
	mult_label.show()
	check_for_cards()

func check_for_cards():
	if CardManager.current_cards.has(preload("res://Scenes/dealers_cut.tscn")):
		CardEffects.dealers_cut(base, mult)
		if CardEffects.dealers_int != 0:
			await get_tree().create_timer(1.5).timeout
			base = CardEffects.dealers_int
			int_label.text = "" + str(base)
		elif CardEffects.dealers_mult != 0:
			await get_tree().create_timer(1.5).timeout
			mult = CardEffects.dealers_mult
			mult_label.text = "" + str(mult)
	
	if CardManager.current_cards.has(preload("res://Scenes/high_roller_card.tscn")):
		CardEffects.high_roller(base)
		if CardEffects.high_roller_int != 0:
			await get_tree().create_timer(1.5).timeout
			base = CardEffects.high_roller_int
			int_label.text = "" + str(base)
	final_calc()
	
func final_calc():
	added_score_ani()
	await get_tree().create_timer(2.5).timeout
	update_labels()
	check_game_status()
	roll_dice.disabled = false
	

func added_score_ani():
	await get_tree().create_timer(0.75).timeout
	animate_intandmult_labels()
	await get_tree().create_timer(0.6).timeout
	var total = base * mult
	added_score_label.text = "+" + str(total)
	animate_added_score_label()
	await get_tree().create_timer(0.85).timeout
	round_score += total
	update_labels()
	added_score_label.text = "+0"
	added_score_label.position = Vector2(0, 0)
	int_label.text = "0" 
	int_label.position = Vector2(0, 0)
	mult_label.text = "0"
	mult_label.position = Vector2(0, 0)
	
func animate_intandmult_labels():
	var tween_int = int_label.create_tween()
	var target_int = Vector2(207, -36)
	var track_pos_int = tween_int.tween_property(int_label, "position", target_int, duration)
	track_pos_int.set_trans(Tween.TRANS_QUAD)
	track_pos_int.set_ease(Tween.EASE_IN_OUT)
	
	var tween_mult = mult_label.create_tween()
	var target_mult = Vector2(-216, -37)
	var track_pos_mult = tween_mult.tween_property(mult_label, "position", target_mult, duration)
	track_pos_mult.set_trans(Tween.TRANS_QUAD)
	track_pos_mult.set_ease(Tween.EASE_IN_OUT)
	
func animate_added_score_label():
	var tween = added_score_label.create_tween()
	var target_pos = Vector2(-415.0, added_score_label.position.y)
	var track_pos = tween.tween_property(added_score_label, "position", target_pos, duration)
	track_pos.set_trans(Tween.TRANS_QUAD)
	track_pos.set_ease(Tween.EASE_IN_OUT)



func check_game_status():
	if GlobalManager.score_needed <= round_score:
		$"Roll Dice".hide()
		GlobalManager.round_status = true
		pass
	if GlobalManager.score_needed > round_score:
		if GlobalManager.dice_rolls == 0:
			game_over()

func game_over():
	GlobalManager.game_over = true
	$"Roll Dice".hide()
	$"Game Over".show()
	GlobalManager.slide_in($"Game Over")


func _on_button_pressed():
	$"Roll Dice".disabled = true
	roll_all_dice()

func _on_click_catcher_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		get_tree().call_group("cards", "hide_description")	

func _on_start_game_pressed():
	GlobalManager.slide_out($"Main Menu")
	await get_tree().create_timer(GlobalManager.tween_out_dur).timeout
	$"Main Menu".hide()
	$"Roll Dice".show()
	
	

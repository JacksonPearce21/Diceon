extends Node

var dice_rolls = 4
var current_round = 0
var score_needed = 40
var money = 10000
var interest = 0
var interest_value = 0
var win_money = 4
var round_status = false
var out_of_shop = false
var game_start = true
var main_menu = true
var game_over = true
var tween_in_dur = 0.5
var tween_out_dur = 0.5


func next_round():
	interest = 0
	dice_rolls = 4
	score_needed *= 1.3
	score_needed = int(score_needed)
	
func decrease_roll():
	dice_rolls -= 1
	
func calc_interest():
	interest_value = money/5
	interest += int(interest_value)

const TARGET_Y := 149
const HIDDEN_Y := 528.0

func slide_in(node: Node2D):
	node.show()
	node.position.y = HIDDEN_Y
	var tween := node.create_tween()
	tween.tween_property(node, "position", Vector2(node.position.x, TARGET_Y), tween_in_dur).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func slide_out(node: Node2D):
	var tween := node.create_tween()
	tween.tween_property(node, "position", Vector2(node.position.x, HIDDEN_Y), tween_out_dur).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN).finished.connect

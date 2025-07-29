extends Node

var dice_rolls = 4
var current_round = 0
var score_needed = 50
var money = 4
var interest = 0
var interest_value = 0
var win_money = 4
var round_status = false
var shopping = false
var game_start = true

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
	

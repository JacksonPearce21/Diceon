extends Node

var dice_rolls = 4
var current_round = 0
var score_needed = 50
var money = 4
var interest = 0
var interest_value = 0
var round_status = false

func next_round():
	current_round += 1
	
func decrease_roll():
	dice_rolls -= 1
	
func round_increase():
	score_needed = score_needed * (current_round * 1.5) + 25
	
func EOR_reset():
	dice_rolls = 4
	
func calc_interest():
	interest_value = money/5
	interest += int(interest_value)
	
func round_win():
	round_status = true
	
	
	

	
	
	

extends Node

var dice_rolls = 4
var current_round = 1
var score_needed = 50
var money = 4

func next_round():
	current_round += 1
	
func decrease_roll():
	dice_rolls -= 1
	
func round_increase():
	score_needed = score_needed * (current_round * 1.5) + 25
	
	

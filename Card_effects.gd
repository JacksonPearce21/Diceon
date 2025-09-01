extends Node

var high_roller_int
var dealers_int
var dealers_mult
var sharp_int
var sharp_mult
var zero_rolls
var roll_amount = 0
var high_roller_label = ""
var dealers_cut_label = ""
var card_sharp_label = ""
var on_the_edge_label = ""
var on_a_roll_label = ""
var treasury_label = ""
var show_on_the_edge_effect
var show_dealers_cut_effect
var show_high_roller_effect 
var show_card_sharp_effect
var show_treasury
var show_on_a_roll


func _ready():
	hide_labels()
	reset_variables()

func high_roller(base_int):
	if base_int == 8:
		high_roller_int = 9
		high_roller_label = "+1 to int"
		show_high_roller_effect = true
	elif base_int == 9:
		high_roller_int = 11
		high_roller_label = "+2 to int"
		show_high_roller_effect = true
	elif base_int == 10:
		high_roller_int = 13
		high_roller_label = "+3 to int"
		show_high_roller_effect = true

func dealers_cut(base_int, base_mult):
	if base_int > base_mult:
		dealers_mult = base_mult + 2
		dealers_cut_label = "+2 to mult"
		show_dealers_cut_effect = true
	elif base_int < base_mult:
		dealers_int = base_int + 2
		dealers_cut_label = "+2 to int"
		show_dealers_cut_effect = true
	else:
		dealers_cut_label = "No Effect"

	
func card_sharp(base_int, base_mult):
	if base_int == 1:
		sharp_int = 11
		card_sharp_label = "1 -> 11"
		show_card_sharp_effect = true
	if base_mult == 1:
		sharp_mult = 11
		card_sharp_label = "1 -> 11"
		show_card_sharp_effect = true

func on_the_edge(rolls):
	if rolls == 0:
		zero_rolls = true
		on_the_edge_label = "+$10"
		show_on_the_edge_effect = true
	
	
func hide_labels():
	high_roller_label = ""
	dealers_cut_label = ""
	show_on_the_edge_effect = false
	show_dealers_cut_effect = false
	show_high_roller_effect = false
	show_card_sharp_effect = false
	show_treasury = false
	
func reset_variables():
	high_roller_int = 0
	dealers_int = 0
	dealers_mult = 0
	sharp_int = 0
	sharp_mult = 0
	zero_rolls = false
	
	

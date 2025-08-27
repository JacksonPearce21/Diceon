extends Node

var high_roller_int
var dealers_int
var dealers_mult
var high_roller_label = ""
var dealers_cut_label = ""
var show_on_the_edge_effect
var show_dealers_cut_effect
var show_high_roller_effect 
var show_card_sharp_effect 

func _ready():
	hide_labels()
	reset_variables()

func high_roller(base_int):
	if base_int == 8:
		high_roller_int = 9
		high_roller_label = "+1 to int"
	elif base_int == 9:
		high_roller_int = 11
		high_roller_label = "+2 to int"
	elif base_int == 10:
		high_roller_int = 13
		high_roller_label = "+3 to int"
	else:
		high_roller_label = "No Effect"
	show_high_roller_effect = true

func dealers_cut(base_int, base_mult):
	if base_int > base_mult:
		dealers_mult = base_mult + 1
		dealers_cut_label = "+1 to mult"
	elif base_int < base_mult:
		dealers_int = base_int + 1
		dealers_cut_label = "+1 to int"
	else:
		dealers_cut_label = "No Effect"
	show_dealers_cut_effect = true
	
	
func hide_labels():
	high_roller_label = ""
	dealers_cut_label = ""
	show_on_the_edge_effect = false
	show_dealers_cut_effect = false
	show_high_roller_effect = false
	show_card_sharp_effect = false
	
func reset_variables():
	high_roller_int = 0
	dealers_int = 0
	dealers_mult = 0
	
	

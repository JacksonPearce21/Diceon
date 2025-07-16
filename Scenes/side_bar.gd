extends Node2D

@onready var money_label = $SideBar/Money

func _process(delta):
	money_label.text = "$" + str(GlobalManager.money)

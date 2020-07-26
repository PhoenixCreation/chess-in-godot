extends Control

onready var rule_window = $rules
func _ready():
	pass

func _input(event):
	if rule_window.layer == 1 and event is InputEventKey:
		rule_window.layer = -1

func _on_PVP_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")


func _on_Exit_pressed():
	get_tree().quit()


func _on_RULES_pressed():
	rule_window.layer = 1


func _on_PVE_pressed():
	OS.alert("I am sorry but it is still under development. check back soon.","Sorry...:(")

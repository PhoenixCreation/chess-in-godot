extends Node2D

var index_on_board = Vector2(0,0)

func _ready():
	pass

func _process(delta):
	position = index_on_board * 64

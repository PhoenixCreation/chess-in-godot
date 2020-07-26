extends Node2D

onready var map = get_parent()
var index_on_board = Vector2(0,0)

func _ready():
	pass
	
func _process(delta):
	position = index_on_board * (512/8)
	
func check_moves():
	var pawns = map.black_pawns
	var moves = [Vector2(-1,-2),Vector2(-2,-1),Vector2(-2,1),Vector2(-1,2),Vector2(1,2),Vector2(2,1),Vector2(2,-1),Vector2(1,-2)]
	var ps = []
	for move in moves:
		var xp = index_on_board.x + move.x
		var yp = index_on_board.y + move.y
		var check = true
		for pawn in pawns:
			if pawn.index_on_board.x == xp and pawn.index_on_board.y == yp:
				check = false
		if check == true:
			var nv = Vector2(xp,yp)
			ps.append(nv)
	return ps


func check_killable():
	var pawns = map.white_pawns
	var moves = [Vector2(-1,-2),Vector2(-2,-1),Vector2(-2,1),Vector2(-1,2),Vector2(1,2),Vector2(2,1),Vector2(2,-1),Vector2(1,-2)]
	var kill = []
	for move in moves:
		var xp = index_on_board.x + move.x
		var yp = index_on_board.y + move.y
		for pawn in pawns:
			if pawn.index_on_board.x == xp and pawn.index_on_board.y == yp:
				kill.append(pawn)
	return kill

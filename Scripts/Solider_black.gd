extends Node2D

onready var map = get_parent()
var index_on_board = Vector2(0,0)

var firstmove = true

func _ready():
	pass
	
func _process(delta):
	position = index_on_board * (512/8)
	if index_on_board.y > 1 and firstmove == true:
		firstmove = false

func check_moves():
	var pawns = map.black_pawns
	var opawns = map.white_pawns
	var ps = []
	if firstmove == true:
		var xp = index_on_board.x
		var yp = index_on_board.y + 1
		var check = true
		for pawn in pawns:
			if pawn.index_on_board.x == xp and pawn.index_on_board.y == yp:
				check = false
		for pawn in opawns:
			if pawn.index_on_board.x == xp and pawn.index_on_board.y == yp:
				check = false
		if check == true:
			var nv = Vector2(xp,yp)
			ps.append(nv)
		if check == true:
			xp = index_on_board.x
			yp = index_on_board.y + 2
			check = true
			for pawn in pawns:
				if pawn.index_on_board.x == xp and pawn.index_on_board.y == yp:
					check = false
			for pawn in opawns:
				if pawn.index_on_board.x == xp and pawn.index_on_board.y == yp:
					check = false
			if check == true:
				var nv = Vector2(xp,yp)
				ps.append(nv)
		return ps
	else:
		var xp = index_on_board.x
		var yp = index_on_board.y + 1
		var check = true
		for pawn in pawns:
			if pawn.index_on_board.x == xp and pawn.index_on_board.y == yp:
				check = false
		for pawn in opawns:
			if pawn.index_on_board.x == xp and pawn.index_on_board.y == yp:
				check = false
		if check == true:
			var nv = Vector2(xp,yp)
			ps.append(nv)
		return ps
		
func check_killable():
	var kill = []
	var xp = index_on_board.x + 1
	var yp = index_on_board.y + 1
	var opawns = map.white_pawns

	for pawn in opawns:
		if pawn.index_on_board.x == xp and pawn.index_on_board.y == yp:
			kill.append(pawn)
	xp = xp - 2

	for pawn in opawns:
		if pawn.index_on_board.x == xp and pawn.index_on_board.y == yp:
			kill.append(pawn)
	return kill
	
	
	
	
	
	
	
	
	
	
	
	

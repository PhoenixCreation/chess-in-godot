extends Node2D

onready var map = get_parent()
var index_on_board = Vector2(0,0)
var points = 100

func _ready():
	pass

func _process(delta):
	position = index_on_board * (512/8)

func check_moves():
	var pawns = map.black_pawns
	var xv = [1,-1,0]
	var yv = [1,-1,0]
	var ps = []
	for x in xv:
		for y in yv:
			if x==0 and y==0:
				pass
			else:
				var xp = index_on_board.x + x
				var yp = index_on_board.y + y
				if xp >= 0 and xp <= 7 and yp >= 0 and yp <= 7:
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
	var xv = [1,-1,0]
	var yv = [1,-1,0]
	var kill = []
	for x in xv:
		for y in yv:
			if x==0 and y==0:
				pass
			else:
				var xp = index_on_board.x + x
				var yp = index_on_board.y + y
				if xp >= 0 and xp <= 7 and yp >= 0 and yp <= 7:
					for pawn in pawns:
						if pawn.index_on_board.x == xp and pawn.index_on_board.y == yp:
							kill.append(pawn)
	return kill

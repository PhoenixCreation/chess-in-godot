extends Node2D

export var ava: PackedScene
export var kill_animation: PackedScene
export var fire_cracker: PackedScene
export var win_message: PackedScene

onready var camera2 = $Camera
onready var time =$Timer

onready var elephant_black_1 = $Elephant_Black_1
onready var elephant_black_2 = $Elephant_Black_2
onready var horse_black_1 = $Horse_Black_1
onready var horse_black_2 = $Horse_Black_2
onready var camel_black_1 = $Camel_Black_1
onready var camel_black_2 = $Camel_Black_2
onready var king_black = $King_Black
onready var queen_black = $Queen_Black
onready var soliders_black = [$Solider_Black_1,$Solider_Black_2,$Solider_Black_3,$Solider_Black_4,$Solider_Black_5,$Solider_Black_6,$Solider_Black_7,$Solider_Black_8]

onready var elephant_white_1 = $Elephant_white_1
onready var elephant_white_2 = $Elephant_white_2
onready var horse_white_1 = $Horse_white_1
onready var horse_white_2 = $Horse_white_2
onready var camel_white_1 = $Camel_white_1
onready var camel_white_2 = $Camel_white_2
onready var king_white = $King_white
onready var queen_white = $Queen_white
onready var soliders_white = [$Solider_white_1,$Solider_white_2,$Solider_white_3,$Solider_white_4,$Solider_white_5,$Solider_white_6,$Solider_white_7,$Solider_white_8]

onready var bgmusic = $Background_music
onready var kill_music = $kill_music
onready var gameover = $Game_finished

var black_pawns = []
var white_pawns = []
var current_pawn
var clicked = false
var turn = 2
var killable = []

var current_avl_moves = []

func _ready():
	bgmusic.playing = true
	elephant_black_1.index_on_board = Vector2(0,0)
	elephant_black_2.index_on_board = Vector2(7,0)
	horse_black_1.index_on_board = Vector2(1,0)
	horse_black_2.index_on_board = Vector2(6,0)
	camel_black_1.index_on_board = Vector2(2,0)
	camel_black_2.index_on_board = Vector2(5,0)
	king_black.index_on_board = Vector2(3,0)
	queen_black.index_on_board = Vector2(4,0)
	black_pawns = [elephant_black_1,elephant_black_2,horse_black_1,horse_black_2,camel_black_1,camel_black_2,king_black,queen_black]
	for i in range(0,8):
		soliders_black[i].index_on_board = Vector2(i,1)
		black_pawns.append(soliders_black[i])
		
	
	elephant_white_1.index_on_board = Vector2(0,7)
	elephant_white_2.index_on_board = Vector2(7,7)
	horse_white_1.index_on_board = Vector2(1,7)
	horse_white_2.index_on_board = Vector2(6,7)
	camel_white_1.index_on_board = Vector2(2,7)
	camel_white_2.index_on_board = Vector2(5,7)
	king_white.index_on_board = Vector2(4,7)
	queen_white.index_on_board = Vector2(3,7)
	white_pawns = [elephant_white_1,elephant_white_2,horse_white_1,horse_white_2,camel_white_1,camel_white_2,king_white,queen_white]
	for i in range(0,8):
		soliders_white[i].index_on_board = Vector2(i,6)
		white_pawns.append(soliders_white[i])

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if turn == 1:
				if clicked == false:
					var click = get_index_on_board(event.position)
					for black in black_pawns:
						if click == black.index_on_board:
							for i in current_avl_moves:
								i.free()
							current_avl_moves.clear()
							var ans1 = black.check_moves()
							current_pawn = black
							for ans in ans1:
								var avl = ava.instance()
								self.add_child(avl)
								avl.index_on_board = ans
								current_avl_moves.append(avl)
							killable = current_pawn.check_killable()
							for i in killable:
								var avl = ava.instance()
								self.add_child(avl)
								avl.index_on_board = i.index_on_board
								avl.get_node("ColorRect").color = Color(1,0,0)
								current_avl_moves.append(avl)
					if current_avl_moves.size() > 0:
						clicked = true
				else:
#					print("executing transfer")
					var click = get_index_on_board(event.position)
					for move in current_avl_moves:
						if click == move.index_on_board:
							current_pawn.index_on_board = click
							for kill in killable:
								if click == kill.index_on_board:
#									print("kill the pawn ",kill.name)
									kill_pawn(kill,true)
									#queue free 'kill'
									#remove it from the respected array of pawn(black_pawns/white_pawns)
							for i in current_avl_moves:
								i.free()
							current_avl_moves.clear()
							clicked = false
							turn = 2
							camera2.rotate(deg2rad(180))
			else:
				if clicked == false:
					var click = get_index_on_board(event.position)
					for black in white_pawns:
						if click == black.index_on_board:
							for i in current_avl_moves:
								i.free()
							current_avl_moves.clear()
							var ans1 = black.check_moves()
							current_pawn = black
							for ans in ans1:
								var avl = ava.instance()
								self.add_child(avl)
								avl.index_on_board = ans
								current_avl_moves.append(avl)
							killable = current_pawn.check_killable()
#							print(killable)
							for i in killable:
								var avl = ava.instance()
								self.add_child(avl)
								avl.index_on_board = i.index_on_board
								avl.get_node("ColorRect").color = Color(1,0,0)
								current_avl_moves.append(avl)
					if current_avl_moves.size() > 0:
						clicked = true
				else:
#					print("executing transfer")
					var click = get_index_on_board(event.position)
					for move in current_avl_moves:
						if click == move.index_on_board:
							current_pawn.index_on_board = click
							for kill in killable:
								if click == kill.index_on_board:
#									print("kill the pawn ",kill.name)
									kill_pawn(kill,false)
									#queue free 'kill'
									#remove it from the respected array of pawn(black_pawns/white_pawns)
							for i in current_avl_moves:
								i.free()
							current_avl_moves.clear()
							clicked = false
							turn = 1
							camera2.rotate(deg2rad(0))
						
	elif event is InputEventScreenTouch:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if turn == 1:
				if clicked == false:
					var click = get_index_on_board(event.position)
					for black in black_pawns:
						if click == black.index_on_board:
							for i in current_avl_moves:
								i.free()
							current_avl_moves.clear()
							var ans1 = black.check_moves()
							current_pawn = black
							for ans in ans1:
								var avl = ava.instance()
								self.add_child(avl)
								avl.index_on_board = ans
								current_avl_moves.append(avl)
							killable = current_pawn.check_killable()
							for i in killable:
								var avl = ava.instance()
								self.add_child(avl)
								avl.index_on_board = i.index_on_board
								avl.get_node("ColorRect").color = Color(1,0,0)
								current_avl_moves.append(avl)
					if current_avl_moves.size() > 0:
						clicked = true
				else:
#					print("executing transfer")
					var click = get_index_on_board(event.position)
					for move in current_avl_moves:
						if click == move.index_on_board:
							current_pawn.index_on_board = click
							for kill in killable:
								if click == kill.index_on_board:
#									print("kill the pawn ",kill.name)
									kill_pawn(kill,true)
									#queue free 'kill'
									#remove it from the respected array of pawn(black_pawns/white_pawns)
							for i in current_avl_moves:
								i.free()
							current_avl_moves.clear()
							clicked = false
							turn = 2
			else:
				if clicked == false:
					var click = get_index_on_board(event.position)
					for black in white_pawns:
						if click == black.index_on_board:
							for i in current_avl_moves:
								i.free()
							current_avl_moves.clear()
							var ans1 = black.check_moves()
							current_pawn = black
							for ans in ans1:
								var avl = ava.instance()
								self.add_child(avl)
								avl.index_on_board = ans
								current_avl_moves.append(avl)
							killable = current_pawn.check_killable()
#							print(killable)
							for i in killable:
								var avl = ava.instance()
								self.add_child(avl)
								avl.index_on_board = i.index_on_board
								avl.get_node("ColorRect").color = Color(1,0,0)
								current_avl_moves.append(avl)
					if current_avl_moves.size() > 0:
						clicked = true
				else:
#					print("executing transfer")
					var click = get_index_on_board(event.position)
					for move in current_avl_moves:
						if click == move.index_on_board:
							current_pawn.index_on_board = click
							for kill in killable:
								if click == kill.index_on_board:
#									print("kill the pawn ",kill.name)
									kill_pawn(kill,false)
									#queue free 'kill'
									#remove it from the respected array of pawn(black_pawns/white_pawns)
							for i in current_avl_moves:
								i.free()
							current_avl_moves.clear()
							clicked = false
							turn = 1
		

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		pass
		
		
		
func kill_pawn(pawn,black):
	bgmusic.stop()
	kill_music.play()
	if black == true:
		var index = -1
		for i in range(white_pawns.size()):
			if white_pawns[i] == pawn:
				index = i
		if white_pawns[index].name == "King_white":
			game_over(true) 
		if not index == -1:
			var anim = kill_animation.instance()
			self.add_child(anim)
			anim.index_on_board = white_pawns[index].index_on_board
			white_pawns[index].queue_free()
			white_pawns.remove(index)
	else:
		var index = -1
		for i in range(black_pawns.size()):
			if black_pawns[i] == pawn:
				index = i
		if black_pawns[index].name == "King_Black":
			game_over(false)
		if not index == -1:
			var anim = kill_animation.instance()
			self.add_child(anim)
			anim.index_on_board = black_pawns[index].index_on_board
			black_pawns[index].queue_free()
			black_pawns.remove(index)
			
			
func game_over(black_win):
	bgmusic.stop()
	kill_music.stop()
	gameover.play()
	var message = win_message.instance()
	self.add_child(message)
	
	var fire1 = fire_cracker.instance()
	self.add_child(fire1)
	fire1.position = Vector2(128,128)
	var fire2 = fire_cracker.instance()
	self.add_child(fire2)
	fire2.position = Vector2(512-128,512-128)
	var fire3 = fire_cracker.instance()
	self.add_child(fire3)
	fire3.position = Vector2(128,512-128)
	var fire4 = fire_cracker.instance()
	self.add_child(fire4)
	fire4.position = Vector2(512-128,128)
	
	time.start()
	set_process(false)
	set_process_input(false)
	if black_win == true:
		print("black won")
	else:
		message.label.text = "....White Player won...."
		print("white won")

func get_index_on_board(pos):
	var ps = Vector2.ZERO
	ps.x = floor(pos.x * 8 / 512)
	ps.y = floor(pos.y * 8 / 512)
	return ps


func _on_kill_music_finished():
	bgmusic.play()


func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/MAIN_SCREEN.tscn")

extends Node2D

onready var map = get_parent()
var index_on_board = Vector2(0,0)
var size = 8
var points = 10

onready var ray_up = $Up
onready var ray_down = $Down
onready var ray_left = $Left
onready var ray_right = $Right
onready var rays = [ray_down,ray_left,ray_up,ray_right]

func _ready():
	ray_down.add_exception(self)
	ray_up.add_exception(self)
	ray_left.add_exception(self)
	ray_right.add_exception(self)

func _process(delta):
	position = index_on_board * (512/8)

func check_moves():
	var pos = []
	if ray_down.is_colliding():
		var dn = map.get_index_on_board(ray_down.get_collision_point())
		pos.append(dn)
	if ray_up.is_colliding():
		var dn = map.get_index_on_board(ray_up.get_collision_point())
		pos.append(dn)
	if ray_left.is_colliding():
		var dn = map.get_index_on_board(ray_left.get_collision_point())
		pos.append(dn)
	if ray_right.is_colliding():
		var dn = map.get_index_on_board(ray_right.get_collision_point())
		pos.append(dn)
	var ps = []
	for psnt in pos:
		for i in range(0,8):
			for j in range(0,8):
				if i == index_on_board.x and j == index_on_board.y:
					pass
				elif i == psnt.x and j == psnt.y:
					pass
				else:
					var check = is_between_points(index_on_board.x,index_on_board.y,psnt.x,psnt.y,i,j)
					if check == true:
						var nv = Vector2(i,j)
						ps.append(nv)
	return ps


func check_killable():
	var kill=[]
	for ray in rays:
		if ray.is_colliding():
			if ray.get_collider().get_parent().is_in_group("black"):
				var nv = ray.get_collider().get_parent()
				kill.append(nv)
	return kill

func is_between_points(x1,y1,x2,y2,x3,y3):
	var a = (x1 * (y2 - y3) +
		 x2 * (y3 - y1) + 
		 x3 * (y1 - y2)) 
	var is_on_line = false
	var is_between = false
	var result = false
	if x1 == x2:
		is_on_line = x3 == x1
		is_between = min(y1, y2) < y3 and y3 < max(y1,y2)
		result = is_on_line and is_between
	else:
		var slope = (y2 - y1)/(x2 - x1) 
		is_on_line = (y3 - y1) == (slope * (x3 - x1)) 
		is_between = (min(x1, x2) <= x3 and x3 <= max(x1,x2)) and (min(y1, y2) <= y3 and y3 <= max(y1,y2))
		result = is_on_line and is_between
	return result

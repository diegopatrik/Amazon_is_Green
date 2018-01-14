extends Node2D

var achou

onready var map = get_node("../nav/TileMap")

var start_pos = Vector2()

var id setget get_id

func get_id():
	return id

func _ready():
	randomize()
	
	while(achou!=true):
		var x_pos = floor(rand_range(-16, 47))
		var y_pos = floor(rand_range(-9, 26))
		
		if(map.get_cell(x_pos, y_pos) != 1):
			#map.set_cell(x_pos, y_pos, 1)
			var d_pos = map.map_to_world(Vector2(x_pos,y_pos))
			set_pos(d_pos)
			achou = true
			start_pos = Vector2(x_pos, y_pos)

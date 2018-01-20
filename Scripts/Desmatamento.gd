extends Node2D

var tamanho = 0

#indica se achou um lugar viável para desmatar
var achou = false
var achou2 = false

#posição em x e y do atual
# desmatamento em curso
var x_pos
var y_pos

#referencia ao tilemap
onready var map = get_node("../nav/TileMap")
#referencia ao timer
onready var timer = get_node("time_pra_crescer")

#posição inicial
var start_pos = Vector2()

#construtor que recebe tamanho
#do desmatamento
func _construtor(numero):
	tamanho = numero

func _ready():
	randomize()
	
	while(achou!=true):
		x_pos = floor(rand_range(-16, 47))
		y_pos = floor(rand_range(-9, 26))
		
		if(map.get_cell(x_pos, y_pos) == 0):
			map.set_cell(x_pos, y_pos, 1)
			var d_pos = map.map_to_world(Vector2(x_pos,y_pos))
			set_pos(d_pos)
			achou = true
			start_pos = Vector2(x_pos, y_pos)
			timer.start()

func _on_time_pra_crescer_timeout():
	
	while(achou2!=true and tamanho > 0):
		
		if(map.get_cell(x_pos+1,y_pos) == 0):
			x_pos = x_pos+1
			var d_pos = map.map_to_world(Vector2(x_pos,y_pos))
			set_pos(d_pos)
			achou2 = true
			map.set_cell(x_pos, y_pos, 1)
			timer.start()
			
		elif(map.get_cell(x_pos-1,y_pos) == 0):
			x_pos = x_pos-1
			var d_pos = map.map_to_world(Vector2(x_pos,y_pos))
			set_pos(d_pos)
			achou2 = true
			map.set_cell(x_pos, y_pos, 1)
			timer.start()
			
		elif(map.get_cell(x_pos+1,y_pos+1) == 0):
			x_pos = x_pos+1
			y_pos = y_pos+1
			var d_pos = map.map_to_world(Vector2(x_pos,y_pos))
			set_pos(d_pos)
			achou2 = true
			map.set_cell(x_pos, y_pos, 1)
			timer.start()
			
		elif(map.get_cell(x_pos-1,y_pos-1) == 0):
			x_pos = x_pos-1
			y_pos = y_pos-1
			var d_pos = map.map_to_world(Vector2(x_pos,y_pos))
			set_pos(d_pos)
			achou2 = true
			map.set_cell(x_pos, y_pos, 1)
			timer.start()
			
		elif(map.get_cell(x_pos+1,y_pos-1) == 0):
			x_pos = x_pos+1
			y_pos = y_pos-1
			var d_pos = map.map_to_world(Vector2(x_pos,y_pos))
			set_pos(d_pos)
			achou2 = true
			map.set_cell(x_pos, y_pos, 1)
			timer.start()
			
		elif(map.get_cell(x_pos-1,y_pos+1) == 0):
			x_pos = x_pos-1
			y_pos = y_pos+1
			var d_pos = map.map_to_world(Vector2(x_pos,y_pos))
			set_pos(d_pos)
			achou2 = true
			map.set_cell(x_pos, y_pos, 1)
			timer.start()
			
		elif(map.get_cell(x_pos,y_pos+1) == 0):
			y_pos = y_pos+1
			var d_pos = map.map_to_world(Vector2(x_pos,y_pos))
			set_pos(d_pos)
			achou2 = true
			map.set_cell(x_pos, y_pos, 1)
			timer.start()
			
		elif(map.get_cell(x_pos,y_pos-1) == 0):
			y_pos = y_pos-1
			var d_pos = map.map_to_world(Vector2(x_pos,y_pos))
			set_pos(d_pos)
			achou2 = true
			map.set_cell(x_pos, y_pos, 1)
			timer.start()
			
	tamanho -= 1
	if achou2:
		tamanho -= 1
		Globals.set("floresta", Globals.get("floresta") - 0.043402777777778)
	if(tamanho > 0):
		achou2 = false
	

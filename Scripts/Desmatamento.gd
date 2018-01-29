extends KinematicBody2D

var tamanho = 0
var crescendo = true

#variavel para num aleatorio e match
var numero_a = 0
var numero_b = 0

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

func _stop():
	tamanho = 0

func _ready():
	randomize()
	
	#variável auxiliar
	var achou = false
	var tentativas = 0
	
	#inicializa x e y
	x_pos = floor(rand_range(-16, 47))
	y_pos = floor(rand_range(-9, 26))
	
	while(achou!=true):
		
		#limita x e y para nao gerar mt proximo da base
		while( (x_pos>10 and x_pos<21) and (y_pos>5 and y_pos<12) ):
			x_pos = floor(rand_range(-16, 47))
			y_pos = floor(rand_range(-9, 26))
			if tentativas > 64:
				achou = true
				queue_free()
		
		if(map.get_cell(x_pos, y_pos) == 0 and tentativas <= 64):
			map.set_cell(x_pos, y_pos, 1)
			var d_pos = map.map_to_world(Vector2(x_pos,y_pos))
			set_pos(d_pos)
			Globals.set("floresta", Globals.get("floresta") - 0.043402777777778)
			tamanho -= 1
			achou = true
			start_pos = Vector2(x_pos, y_pos)
			timer.start()
			
		tentativas += 1
		if tentativas > 64:
			achou = true
			queue_free()

func _on_time_pra_crescer_timeout():
	
	var achou = false
	var tentativas = 0
	
	if(tamanho > 0):
		while(achou!=true):
			
			numero_a = rand_range(1,2)
			timer.set_wait_time(numero_a)
			
			numero_b = ceil(rand_range(1,8))
			
			if(numero_b == 1 and map.get_cell(x_pos+1,y_pos) == 0):
				x_pos = x_pos+1
				var d_pos = map.map_to_world(Vector2(x_pos,y_pos))
				move_to(d_pos)
				achou = true
				map.set_cell(x_pos, y_pos, 1)
				timer.start()
				
			elif(numero_b == 2 and map.get_cell(x_pos-1,y_pos) == 0):
				x_pos = x_pos-1
				var d_pos = map.map_to_world(Vector2(x_pos,y_pos))
				move_to(d_pos)
				achou = true
				map.set_cell(x_pos, y_pos, 1)
				timer.start()
				
			elif(numero_b == 3 and map.get_cell(x_pos+1,y_pos+1) == 0):
				x_pos = x_pos+1
				y_pos = y_pos+1
				var d_pos = map.map_to_world(Vector2(x_pos,y_pos))
				move_to(d_pos)
				achou = true
				map.set_cell(x_pos, y_pos, 1)
				timer.start()
				
			elif(numero_b == 4 and map.get_cell(x_pos-1,y_pos-1) == 0):
				x_pos = x_pos-1
				y_pos = y_pos-1
				var d_pos = map.map_to_world(Vector2(x_pos,y_pos))
				move_to(d_pos)
				achou = true
				map.set_cell(x_pos, y_pos, 1)
				timer.start()
				
			elif(numero_b == 5 and map.get_cell(x_pos+1,y_pos-1) == 0):
				x_pos = x_pos+1
				y_pos = y_pos-1
				var d_pos = map.map_to_world(Vector2(x_pos,y_pos))
				move_to(d_pos)
				achou = true
				map.set_cell(x_pos, y_pos, 1)
				timer.start()
				
			elif(numero_b == 6 and map.get_cell(x_pos-1,y_pos+1) == 0):
				x_pos = x_pos-1
				y_pos = y_pos+1
				var d_pos = map.map_to_world(Vector2(x_pos,y_pos))
				move_to(d_pos)
				achou = true
				map.set_cell(x_pos, y_pos, 1)
				timer.start()
				
			elif(numero_b == 7 and map.get_cell(x_pos,y_pos+1) == 0):
				y_pos = y_pos+1
				var d_pos = map.map_to_world(Vector2(x_pos,y_pos))
				move_to(d_pos)
				achou = true
				map.set_cell(x_pos, y_pos, 1)
				timer.start()
				
			elif(numero_b == 8 and map.get_cell(x_pos,y_pos-1) == 0):
				y_pos = y_pos-1
				var d_pos = map.map_to_world(Vector2(x_pos,y_pos))
				move_to(d_pos)
				achou = true
				map.set_cell(x_pos, y_pos, 1)
				timer.start()
			
			tentativas += 1
			if tentativas > 64:
				achou = true
				queue_free()
			
		if achou and tentativas < 64:
			tamanho = tamanho - 1
			Globals.set("floresta", Globals.get("floresta") - 0.043402777777778)
			if tamanho == 0:
				queue_free()
	else:
		# TODO delay para n sumir instantaneamente após helicoptero
		#ou veiculo chegar
		get_node("delay").start()
		queue_free()
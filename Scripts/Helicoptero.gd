extends KinematicBody2D

var valor = 500 setget get_valor

# velocidade em pixel/s
export var speed = 60

# identifica se o helicoptero foi selecionado
var selected = false

# at which distance to stop moving
# NOTE: setting this value too low might result in jerky movement near destination
#const eps = 1.5

# points in the path
var points = []
var destino = null

func get_valor():
	return valor

func _ready():
	set_fixed_process(true)
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("mouse_click") and selected and ( Globals.get("selected_now") == self.get_name() ):
		points = get_node("../nav").get_simple_path(get_pos(), get_global_mouse_pos(), false)
		destino = get_global_mouse_pos()

func _fixed_process(delta):
	
	if(is_colliding()):
		print(get_collider().get_name())
	
	#verifica se há desmatamento
	#trocar posteriormente por detecção de colisão
	var cell = get_node("../nav/TileMap").world_to_map(get_global_pos())
	if(get_node("../nav/TileMap").get_cell(cell.x, cell.y) == 1):
		print("achou terra")
	# refresh the points in the path
	# if the path has more than one point
	if points.size() > 1 and destino != null:
		var distance = get_pos().distance_to(points[0]) #destino - points[1]
		#var direction = distance.normalized() # direction of movement
		if distance > 2: #distance.length() > eps or points.size() > 2:
			set_pos(get_pos().linear_interpolate(points[0], (speed * delta)/distance))
			#set_linear_velocity(direction*speed)
			#points = get_node("../Navigation2D").get_simple_path(get_pos(), destino, false)
		else:
			points.remove(0)
			selected = false
			get_node("Label").set("visibility/visible", false)
			#set_linear_velocity(Vector2(0, 0)) # close enough - stop moving
			#print("chegou ao destino")
		update() # we update the node so it has to draw it self again

func _draw():
	# if there are points to draw
	if points.size() > 2:
		for p in points:
			draw_circle(p - get_global_pos(), 1, Color(0, 1, 1)) # we draw a circle (convert to global position first)

func _on_TextureButton_pressed():
	get_node("Label").set("visibility/visible", true)
	Globals.set("selected_now", self.get_name())
	selected = true
	#update()

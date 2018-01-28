extends KinematicBody2D

var valor = 1000 setget get_valor

#variavel auxiliar para saber quando está a caminho
var moving = false

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

#---------- FOG -----------
var position # Helicoptero's position

# Iteration variables
var x
var y

# variáveis p checar se o helicoptero se moveu
var x_old
var y_old

# Array to build up the visible area like a square.
# First value determines the width/height of the tip.
# Here it would be 2*2 + 1 = 5 tiles wide/high.
# Second value determines the total squares size.
# Here it would be 5*2 + 1 = 10 tiles wide/high.
var l = range(2, 5)

#---------- FOG -----------^^

func get_valor():
	return valor

func _ready():
	set_fixed_process(true)
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("mouse_click") and selected and ( Globals.get("selected_now") == self.get_name() ):
		points = get_node("../nav").get_simple_path(get_pos(), get_global_mouse_pos(), false)
		destino = get_global_mouse_pos()
		moving = true

func atualiza_fog():
	
	position = get_pos()
	
	# Calculate the corresponding tile
	# from the players position
	x = int(position.x/get_node("../fog").get_cell_size().x)
	# Switching from positive to negative tile positions
	# causes problems because of rounding problems
	if position.x < 0:
		x -= 1 # Correct negative values
	
	y = int(position.y/get_node("../fog").get_cell_size().y)
	if (position.y < 0):
		y -= 1
	
	# Check if the player moved one tile further
	if ((x_old != x) or (y_old != y)):
		# Create the transparent part (visited area)
		var end = l.size() - 1
		var start = 0
		for steps in range(l.size()):
			for m in range(x - l[end] - 1, x + l[end] + 2):
				for n in range(y - l[start] - 1, y + l[start] + 2):
					if (get_node("../fog").get_cell(m, n) != 0):
						get_node("../fog").set_cell(m, n, 1, 0, 0)
			end -= 1
			start += 1
		
		# Create the actual and active visible part
		var end = l.size() - 1
		var start = 0
		for steps in range(l.size()):
			for m in range(x - l[end], x + l[end] + 1):
				for n in range(y - l[start], y + l[start] + 1):
					get_node("../fog").set_cell(m, n, -1)
			end -= 1
			start += 1
	
	x_old = x
	y_old = y


func _fixed_process(delta):
	
	# refresh the points in the path
	# if the path has more than one point
	if points.size() > 1 and destino != null:
		var distance = get_pos().distance_to(points[0]) 
		if distance > 2:
			set_pos(get_pos().linear_interpolate(points[0], (speed * delta)/distance))
		else:
			points.remove(0)
			selected = false
			get_node("Label").set("visibility/visible", false)
		update() # we update the node so it has to draw it self again
		
		atualiza_fog()
	

func _draw():
	# if there are points to draw
	if points.size() > 2:
		for p in points:
			draw_circle(p - get_global_pos(), 2, Color(0, 1, 1)) # we draw a circle (convert to global position first)

func _on_TextureButton_pressed():
	#ao tocar, caso esteja se movendo
	#para de se mover
	if moving:
		destino = null
		points = []
		update()
	
	get_node("Label").set("visibility/visible", true)
	Globals.set("selected_now", self.get_name())
	selected = true

func _on_Area2D_body_enter( body ):
	if body.is_in_group("desmatamento"):
		print("HHH Desmatamento impedido")
		points = get_node("../nav").get_simple_path(get_pos(), body.get_global_pos(), false)
		destino = body.get_global_pos()
		body._stop()

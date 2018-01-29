extends KinematicBody2D

var valor = 500 setget get_valor

# velocidade em pixel/s
export var speed = 60

# points in the path
var points = []
var destino = null

func get_valor():
	return valor

func _goto_desmatamento( body ):
		points = get_node("../nav").get_simple_path(get_pos(), body.get_global_pos(), false)
		destino = body.get_global_pos()

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	
	# refresh the points in the path
	# if the path has more than one point
	if points.size() > 1 and destino != null:
		var distance = get_pos().distance_to(points[0]) 
		if distance > 2:
			set_pos(get_pos().linear_interpolate(points[0], (speed * delta)/distance))
		else:
			points.remove(0)
		update() # update para redesenhar

func _draw():
	# caso tenha pontos, ele desenha
	if points.size() > 2:
		for p in points:
			draw_circle(p - get_global_pos(), 2, Color(0, 1, 1)) # we draw a circle (convert to global position first)

func _on_Area2D_body_enter( body ):
	if body.is_in_group("desmatamento"):
		print("VVV Desmatamento impedido")
		points = get_node("../nav").get_simple_path(get_pos(), body.get_global_pos(), false)
		destino = body.get_global_pos()
		body._stop()

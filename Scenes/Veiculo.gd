extends KinematicBody2D

# velocidade em pixel/s
export var speed = 60

# points in the path
var points = []
var destino = null

func _goto_desmatamento(posicao):
		points = get_node("../../nav").get_simple_path(get_pos(), get_global_mouse_pos(), false)
		destino = get_global_mouse_pos()

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
			#selected = false
			#get_node("Label").set("visibility/visible", false)
		update() # we update the node so it has to draw it self again
extends Camera2D

var Event
var t_origem = Vector2()
#código para mover a câmera

func _ready():
	set_process_input(true)

func _on_SwipeDetector_swiped( gesture ):
	set_global_pos(gesture.last_point())
	print(gesture.get_distance())

func _on_SwipeDetector_swipe_updated( partial_gesture ):
	set_global_pos(partial_gesture.last_point())

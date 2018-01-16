extends Camera2D

var Event
var t_origem = Vector2()
#código para mover a câmera

func _ready():
	set_process_input(true)

func _on_SwipeDetector_swiped( gesture ):
	set_pos(gesture.last_point())

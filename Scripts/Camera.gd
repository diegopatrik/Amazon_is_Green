extends Camera2D

var zoom = false

var t_origem = Vector2()
#código para mover a câmera

func _ready():
	set_process_input(true)

func _on_SwipeDetector_swiped( gesture ):
	set_global_pos(gesture.last_point())

func _on_SwipeDetector_swipe_updated( partial_gesture ):
	set_global_pos(partial_gesture.last_point())


func _on_Button_zoom_pressed():
	if zoom:
		set_zoom(Vector2(1,1))
		zoom = false
	else:
		set_zoom(Vector2(2,2))
		zoom = true

extends Camera2D

var Event
var t_origem = Vector2()
#código para mover a câmera

func _ready():
	set_process_input(true)

func _input(event):
	Event = make_input_local(event)
	if Event.type == InputEvent.SCREEN_DRAG:
		set_pos(get_pos() + Event.pos)

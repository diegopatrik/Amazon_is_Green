extends TileMap

func _ready():
	set_process(true)

func _process(delta):
	if Input.is_mouse_button_pressed(1):
		var pos = world_to_map(get_global_mouse_pos())
		set_cell(pos.x, pos.y, 1)
extends Camera2D

#código para mover e limitar a câmera

func _ready():
	pass

func _on_Button_direita_pressed():
	if get_pos().x < 1024:
		set_pos(get_pos() + Vector2(64,0))

func _on_Button_baixo_pressed():
	if get_pos().y < 576:
		set_pos(get_pos() + Vector2(0,64))

func _on_Button_cima_pressed():
	if get_pos().y > 0:
		set_pos(get_pos() + Vector2(0,-64))

func _on_Button_esquerda_pressed():
	if get_pos().x > 0:
		set_pos(get_pos() + Vector2(-64,0))

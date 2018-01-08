extends Node

#area de floresta
var floresta = 100
#dinheiro disponível
var dinheiro = 10000

onready var txt_floresta = get_node("./HUD/Floresta")
onready var txt_dinheiro = get_node("./HUD/Dinheiro")
onready var map = get_node("./nav/TileMap")

var cena_helicoptero = preload("res://Scenes/Helicoptero.tscn")
var position = Vector2(448,288)

var cena_desmatamento = preload("res://Scenes/Desmatamento.tscn")

func _ready():
	randomize()
	txt_dinheiro.set_text("dinheiro disponivel: " + str(dinheiro))
	txt_floresta.set_text("area preservada: " + str(floresta) + "%")

func _on_Button_pressed():
	var helicoptero = cena_helicoptero.instance()
	if helicoptero.get_valor() <= dinheiro:
		add_child(helicoptero)
		helicoptero.set_pos(position + Vector2(-32,0))
		if(helicoptero.get_pos().x <= 352):
			position = Vector2(448,288)
		else:
			position = helicoptero.get_pos()
		dinheiro -= helicoptero.get_valor()
		txt_dinheiro.set_text("dinheiro disponivel: " + str(dinheiro))


func _on_gerador_desmatamento_timeout():
	var x_pos = floor(rand_range(-16, 47))
	var y_pos = floor(rand_range(-9, 26))
	
	map.set_cell(x_pos, y_pos, 1)
	var d_pos = map.map_to_world(Vector2(x_pos,y_pos))
	var desmatamento = cena_desmatamento.instance()
	desmatamento.set_pos(d_pos)
	print("gerou" + str(Vector2(x_pos,y_pos)))
	
	

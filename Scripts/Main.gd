extends Node

#area de floresta
var floresta = 100
#dinheiro disponível
var dinheiro = 10000

onready var txt_floresta = get_node("./HUD/Floresta")
onready var txt_dinheiro = get_node("./HUD/Dinheiro")
onready var txt_tempo = get_node("./HUD/Tempo")
onready var map = get_node("./nav/TileMap")
onready var tempo = get_node("./tempo_restante")

var cena_helicoptero = preload("res://Scenes/Helicoptero.tscn")
var position = Vector2(448,288)

var cena_desmatamento = preload("res://Scenes/Desmatamento.tscn")

func _ready():
	randomize()
	txt_dinheiro.set_text("dinheiro disponivel: " + str(dinheiro))
	txt_floresta.set_text("area preservada: " + str(floresta) + "%")
	set_process(true)

#converte o tempo do contador para segundos e retorna um array
#com minutos e segundos atuais
func _converte_seg_min(tempo_em_seg):
	var minutos = tempo_em_seg / 60
	var segundos = tempo_em_seg % 60
	
	print([minutos, segundos])
	return [minutos, segundos]
	

func _process(delta):
	var res_tempo = _converte_seg_min(int(tempo.get_time_left()))
	txt_tempo.set_text( str( " %02d : %02d" % [res_tempo[0], res_tempo[1]] ) )

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
	#temporário
	#TODO lógica do desmatamento que se inicia
	#num lugar e vai crescendo ao redor
	#ao menos se seja contido
	
	var x_pos = floor(rand_range(-16, 47))
	var y_pos = floor(rand_range(-9, 26))
	
	map.set_cell(x_pos, y_pos, 1)
	var d_pos = map.map_to_world(Vector2(x_pos,y_pos))
	var desmatamento = cena_desmatamento.instance()
	desmatamento.set_pos(d_pos)
	print("gerou" + str(Vector2(x_pos,y_pos)))

func _game_over():
	pass # replace with function body

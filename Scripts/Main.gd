extends Node

var contador = 0

#tamanho do mapa em qnt de cells
var floresta_size = 2304

#dinheiro disponível
var dinheiro = 10000

#recursos
var qnt_aeronave = 0
var qnt_veiculo = 0
var qnt_agente = 0

onready var txt_floresta = get_node("./HUD/Floresta")
onready var txt_dinheiro = get_node("./HUD/Dinheiro")
onready var txt_tempo = get_node("./HUD/Tempo")
onready var txt_aeronaves = get_node("./HUD/Aeronaves")
onready var txt_agentes = get_node("./HUD/Agentes")
onready var map = get_node("./nav/TileMap")
onready var tempo = get_node("./tempo_restante")

onready var cena_helicoptero = preload("res://Scenes/Helicoptero.tscn")
var position = Vector2(448,288)

onready var cena_desmatamento = preload("res://Scenes/Desmatamento.tscn")

func _ready():
	randomize()
	txt_dinheiro.set_text("dinheiro disponivel: " + str(dinheiro))
	txt_floresta.set_text("area preservada: " + str(Globals.get("floresta")) + "%")
	#area da floresta
	Globals.set("floresta", 100.0)
	set_process(true)

#converte o tempo do contador para segundos e retorna um array
#com minutos e segundos atuais
func _converte_seg_min(tempo_em_seg):
	var minutos = tempo_em_seg / 60
	var segundos = tempo_em_seg % 60
	
	return [minutos, segundos]

func _process(delta):
	var res_tempo = _converte_seg_min(int(tempo.get_time_left()))
	txt_tempo.set_text( str( " %02d : %02d" % [res_tempo[0], res_tempo[1]] ) )
	txt_floresta.set_text("area preservada: %.1f" % [Globals.get("floresta")] + "%")
	txt_aeronaves.set_text("aeronaves: " + str(qnt_aeronave))
	txt_agentes.set_text("agentes: " + str(qnt_agente))

func _on_Button_pressed():
	var helicoptero = cena_helicoptero.instance()
	if helicoptero.get_valor() <= dinheiro:
		add_child(helicoptero)
		qnt_aeronave += 1
		helicoptero.set_pos(position + Vector2(-32,0))
		if(helicoptero.get_pos().x <= 352):
			position = Vector2(448,288)
		else:
			position = helicoptero.get_pos()
		dinheiro -= helicoptero.get_valor()
		txt_dinheiro.set_text("dinheiro disponivel: " + str(dinheiro))

func _on_gerador_desmatamento_timeout():
	
	#valor random para tamanho do desmatamento
	var num = floor(rand_range(1, 50))

	var d = cena_desmatamento.instance()
	d._construtor(num)
	add_child(d)
	
	#0.043402777777778 representa 1 cell da area de floresta
	Globals.set("floresta", Globals.get("floresta") - 0.043402777777778)
	contador += 1

func _game_over():
	pass # replace with function body

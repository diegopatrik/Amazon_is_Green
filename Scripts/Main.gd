extends Node

var contador = 0

#tamanho do mapa em qnt de cells
var floresta_size = 2304

#dinheiro disponível
var dinheiro = 5000

#recursos
var qnt_aeronave = 0
var qnt_veiculo = 0
var qnt_agente = 0

#velocidade
var velocidade_helicopteros = 60
var velocidade_veiculos = 60

#textos
onready var txt_floresta = get_node("./HUD/Floresta")
onready var txt_dinheiro = get_node("./HUD/Dinheiro")
onready var txt_tempo = get_node("./HUD/Tempo")
onready var txt_aeronaves = get_node("./HUD/Aeronaves")
onready var txt_agentes = get_node("./HUD/Agentes")
onready var txt_mensagem = get_node("./HUD/Mensagem")

onready var map = get_node("./nav/TileMap")
onready var tempo = get_node("./tempo_restante")

onready var cena_helicoptero = preload("res://Scenes/Helicoptero.tscn")
var position_H = Vector2(448,288)

onready var cena_desmatamento = preload("res://Scenes/Desmatamento.tscn")
var position_V = Vector2(576,288)

onready var cena_veiculo = preload("res://Scenes/Veiculo.tscn")

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

func _on_solicitar_Helicoptero_pressed():
	var helicoptero = cena_helicoptero.instance()
	if helicoptero.get_valor() <= dinheiro and qnt_agente >= 4:
		add_child(helicoptero)
		qnt_aeronave += 1
		helicoptero.set_pos(position_H + Vector2(-32,0))
		if(helicoptero.get_pos().x <= 352):
			position_H = Vector2(448,288)
		else:
			position_H = helicoptero.get_pos()
		dinheiro -= helicoptero.get_valor()
		txt_dinheiro.set_text("dinheiro disponivel: " + str(dinheiro))
	else:
		txt_mensagem.set_text("É necessário $1000 e 4 agentes para solicitar um Helicóptero")
		get_node("HUD/Panel/MensagemTimer").start()

func _on_solicitar_Veiculo_pressed():
	var veiculo = cena_veiculo.instance()
	if veiculo.get_valor() <= dinheiro and qnt_agente >= 2:
		add_child(veiculo)
		qnt_veiculo += 1
		veiculo.set_pos(position_V + Vector2(48,0))
		if(veiculo.get_pos().x > 720):
			position_V = Vector2(576,288)
		else:
			position_V = veiculo.get_pos()
		dinheiro -= veiculo.get_valor()
		txt_dinheiro.set_text("dinheiro disponivel: " + str(dinheiro))
	else:
		txt_mensagem.set_text("É necessário $500 e 2 agentes para solicitar um Helicóptero")
		get_node("HUD/Panel/MensagemTimer").start()

#TODO
func _on_solicitar_Agente_pressed():
	if dinheiro >= 100:
		dinheiro -= 100
		txt_dinheiro.set_text("dinheiro disponivel: " + str(dinheiro))
		qnt_agente += 1

func _on_gerador_desmatamento_timeout():
	
	#valor random para tamanho do desmatamento
	var num = floor(rand_range(1, 50))
	
	#inicia um desmatamento de tamanho num
	var d = cena_desmatamento.instance()
	d._construtor(num)
	add_child(d)

func _game_over():
	#vai para tela de game over
	get_tree().change_scene("res://Scenes/GameOver.tscn")

func _on_MensagemTimer_timeout():
	txt_mensagem.set_text("")

func _on_ButtonUpgrade_pressed():
	for node in get_children():
		if node.has_method("get_moving"):
			if node.get_moving():
				node.set_veloc(node.get_veloc() + 20)

func _on_sair_pressed():
	get_parent().set("visibility/visible", false)

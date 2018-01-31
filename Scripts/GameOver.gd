extends Node2D

var pontuacao = Globals.get("floresta")
onready var txt_pontuacao = get_node("Pontuacao")
onready var txt_parabens = get_node("Parabens")

func _ready():
	
	if pontuacao >= 90:
		#3 estrelas
		txt_parabens.set_text("Parabéns!!!")
		
	elif pontuacao >= 80:
		#2 estrelas
		get_node("Estrela3").set("visibility/opacity", 0.4)
		pass
	elif pontuacao > 70:
		#1 estrela
		get_node("Estrela3").set("visibility/opacity", 0.4)
		get_node("Estrela2").set("visibility/opacity", 0.4)
		pass
	else:
		#0 estrelas
		get_node("Estrela3").set("visibility/opacity", 0.4)
		get_node("Estrela2").set("visibility/opacity", 0.4)
		get_node("Estrela1").set("visibility/opacity", 0.4)
		pass
	
	txt_pontuacao.set_text("Você conseguiu proteger %.1f" % [pontuacao] + "% da floresta!")

func _on_BotaoHome_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")

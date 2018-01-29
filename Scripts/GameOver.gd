extends Node2D

var pontuacao = Globals.get("floresta")
onready var txt_pontuacao = get_node("Pontuacao")

func _ready():
	
	if pontuacao >= 90:
		#3 estrelas
		txt_pontuacao.set_text("Parabéns!!! ")
		
	elif pontuacao >= 80:
		#2 estrelas
		pass
	elif pontucao > 70:
		#1 estrela
		pass
	else:
		#0 estrelas
		pass
	
	txt_pontuacao.set_text("Você conseguiu proteger " + str(pontuacao) + " da floresta")

func _on_BotaoHome_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")

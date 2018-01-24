extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _goto_desmatamento(posicao):
	#substituir por movimento usando navigational2D
	set_pos(posicao)

func _ready():
	pass
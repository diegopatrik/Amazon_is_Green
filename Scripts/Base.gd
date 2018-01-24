extends Node2D

var selecionado = false

func _ready():
	pass

func _on_TextureButton_pressed():
	if not selecionado:
		selecionado = true
		get_node("../HUD/Panel").set("visibility/visible",true)

func _on_Area2D_body_enter( body ):
	if body.is_in_group("desmatamento"):
		print("Desmatamento detectado")
		for node in get_children():
			if  node.has_method("_goto_desmatamento"):
				#do something
				node._goto_desmatamento(body.get_pos())

func _on_sair_pressed():
	if selecionado:
		selecionado = false
		get_node("../HUD/Panel").set("visibility/visible",false)

extends Node2D


func _ready():
	pass

func _on_TextureButton_pressed():
	print("selecionou base")

func _on_Area2D_body_enter( body ):
	if body.is_in_group("desmatamento"):
		print("Desmatamento detectado")

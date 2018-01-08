extends Node

var cena_helicoptero = preload("res://Scenes/Helicoptero.tscn")

func _ready():
	var helicoptero = cena_helicoptero.instance()
	add_child(helicoptero)
	helicoptero.set_pos(200,200)

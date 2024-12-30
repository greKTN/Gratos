extends Control

@onready var animacion = $AnimationPlayer
@onready var texto = $Label
var condicion = ["", ""]


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Maps/Test_map.tscn")

#Si se presiona el personaje se oculta el texto previo
#e inicia la animación para confirmar la selección
func _on_personaje_1_pressed():
	texto.hide()
	animacion.play("selection1")
	

func _on_personaje_2_pressed():
	texto.hide()
	animacion.play("selection2")

func _on_personaje_3_pressed():
	texto.hide()
	animacion.play("selection3")

#Detiene la animación de confirmación y pasa al mapa
func _on_si_pressed():
	if animacion.get_current_animation() == "selection1":
		animacion.stop()
		revision("personaje1")
	elif animacion.get_current_animation() == "selection2":
		animacion.stop()
		revision("personaje2")
	elif animacion.get_current_animation() == "selection3":
		animacion.stop()
		revision("personaje3")

#Detiene la animación de confirmación para poder seleccionar otro personaje
func _on_no_pressed():
	animacion.stop()
	
#revisa la lista para verificar que ambos jugadores hayan escogido personaje
#si se cumple, avanza y muestra el juego
func revision(nombre):
	#se supone que aqui irian las condiciones que
	#modifiquen los elementos de la lista para ambos jugadores
	
	if condicion[0] != "" and condicion[1] != "":
		$".".visible = false
	

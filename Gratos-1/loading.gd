extends Control


func _ready():
	$TextureProgressBar.tint_under = Color(1,1,1,0.5)

#aumenta el valor de las barras de carga
func _on_timer_timeout():
	$ProgressBar.value += 5
	$TextureProgressBar.value += 5

#al finalizar la animación de carga, instancia la pantalla de seleccion de personaje
func _on_animation_player_animation_finished(anim_name: StringName):
	var listo = load("res://selec_personaje.tscn").instantiate()
	get_tree().root.add_child(listo)
	$WorldEnvironment.environment.glow_enabled = false
	$".".visible = false

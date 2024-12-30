extends Node

var peer
var port = 9999
var host_id = 0

# Llama a una funcion segun el estado del jugador
func _ready():
	
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)

func peer_connected(id):
	print("Player connected " + %Player_name.text)
	
func peer_disconnected(id):
	print("Player disconnected " + str(id))
	
#LLama cuando un jugador se conecta al servidor
func connected_to_server():
	print("Connected to server! " + %Player_name.text)
	player_info.rpc_id(1,%Player_name.text,multiplayer.get_unique_id())

	
	
func connection_failed():
	print("Couldn't connect")
	

#Todos los jugadores llaman a la funcion (guarda informacion de los mismos)
@rpc("any_peer")
func player_info(name,id):
	if !PlayerHandle.players.has(id):
		PlayerHandle.players[id] = {
			"name" : name,
			"id" : id,
		}
	
	if multiplayer.is_server():
		for i in PlayerHandle.players:
			player_info.rpc(PlayerHandle.players[i].name, i)


#Inicia el juego al presionar el boton de iniciar 
@rpc("any_peer", "call_local")
func StartGame():
	print("Game started" + %Player_name.text)
	var game = load("res://Maps/Test_map.tscn").instantiate()
	get_tree().root.add_child(game)
	var carga = load("res://loading.tscn").instantiate()
	get_tree().root.add_child(carga)
	$Control.visible = false

func _on_play_button_down():
	peer = ENetMultiplayerPeer.new()
	peer.create_server(port)
	multiplayer.set_multiplayer_peer(peer)
	host_id = multiplayer.get_unique_id()
	
	player_info(%Player_name.text, host_id)
	


func _on_ip_text_submitted(new_string: String):
	_on_join_pressed()


func _on_join_pressed():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(%IP_owner.text, port)
	multiplayer.set_multiplayer_peer(peer)
	
#Al presionar el boton de test, inicia el juego	
@rpc("any_peer", "call_local")
func _on_button_pressed():
	StartGame.rpc()
	_on_play_button_down()

#Al presionar un sprite, iniica el juego
@rpc("any_peer", "call_local")
func _on_sprite_button_pressed():
	_on_button_pressed()

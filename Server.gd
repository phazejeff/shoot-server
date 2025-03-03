extends Node

const PORT = 32169

var players = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var server = ENetMultiplayerPeer.new()
	server.create_server(PORT)
	multiplayer.multiplayer_peer = server
	multiplayer.peer_connected.connect(_on_player_connected)
	print("Running.")

func _on_player_connected(id: int) -> void:
	print("Client " + str(id) + " connected!")
	players[id] = {}

@rpc("any_peer")
func server_update_player_position(id: int, position: Vector2) -> void:
	if id in players:
		players[id]["position"] = position
		print("Updated player " + str(id) + " position to " + str(position))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
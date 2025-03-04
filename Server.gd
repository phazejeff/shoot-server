extends Node
var PlayerActor = load("res://Actors/PlayerActor.gd")
var Utils = load("res://utils/Utils.gd")

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
	players[id] = PlayerActor.new(id)

@rpc("any_peer")
func server_update_player_position(id: int, position: Vector2, head_rotation: float, body_rotation: float) -> void:
	if id in players:
		# TODO: make this an object
		players[id].position = position
		players[id].head_rotation = head_rotation
		players[id].body_rotation = body_rotation
		print("Updated player " + str(id) + " position to " + str(position) + " and head rotation to " + str(head_rotation) + " and set body rotation to " + str(body_rotation))
	
	for player in players.values():
		if id != player.peer_id:
			rpc_id(id, "client_update_player_position", Utils.obj_to_dict(player))

# Client rpc template
@rpc
func client_update_player_position(_player: Dictionary): pass

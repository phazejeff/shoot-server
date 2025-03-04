var peer_id: int:
    get:
        return peer_id

var position: Vector2:
    set(value):
        # Note: logic pertaining to checking if new position is valid for anti-cheat purposes would go in here
        position = value

var head_rotation: float:
    set(value):
        head_rotation = value

var body_rotation: float:
    set(value):
        body_rotation = value

func _init(_peer_id: int) -> void:
    peer_id = _peer_id
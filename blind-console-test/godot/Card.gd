extends Area2D

export var tile:int = 1
var _state:String = "closed" # closed or open
var _clickable = true
var _shared_data:Resource

func initialize(shared_data:Resource) -> void:
	_shared_data = shared_data

func _on_Sprite_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		var button = event as InputEventMouseButton
		if button.pressed:
			self._on_toggle()

func _on_toggle() -> void:
	print("PRE: %s" % _shared_data.num_open)
	if _shared_data.num_open < 2 and self._state == "closed":
		_clickable = false
		self._state = "open"
		_update_sprite()
		_shared_data.num_open += 1
		
func _process(delta):
	if _shared_data.num_open == 2 and self._state == "open":
		self._state = "closed"
		yield(get_tree().create_timer(0.5), "timeout")		
		_update_sprite()
		_clickable = true
		_shared_data.num_open -= 1
	
func _update_sprite():
	if _state == "closed":
		$Sprite.region_rect.position.x = 0
	else:
		$Sprite.region_rect.position.x = tile * 64
		

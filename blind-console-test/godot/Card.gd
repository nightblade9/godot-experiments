extends Area2D

const InterProcessMessenger = preload("res://IPC/InterProcessMessenger.gd")

export var tile:int = 1
var _state:String = "closed" # closed, open, or completed
var _clickable = true
var _shared_data:Resource
var _ipc:InterProcessMessenger

func initialize(shared_data:Resource) -> void:
	_shared_data = shared_data
	_ipc = InterProcessMessenger.new()
	add_child(_ipc)

func complete():
	self._state = "complete"
	self._clickable = false

func _on_Sprite_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		var button = event as InputEventMouseButton
		if button.pressed:
			self._on_toggle()
			_ipc.write_message("Clicked on %s" % self)

func _on_toggle() -> void:
	if len(_shared_data.open_tiles) < 2 and self._state == "closed":
		_clickable = false
		self._state = "open"
		_update_sprite()
		_shared_data.open_tiles.append(self)
		
func _process(_delta):
	if self._state != "complete":
		if len(_shared_data.open_tiles) == 2 and self._state == "open":
			# if not match, close tiles; open matching is done in Main
			if _shared_data.open_tiles[0].tile != _shared_data.open_tiles[1].tile: # tiles match
				self._state = "closed"
				yield(get_tree().create_timer(0.5), "timeout")
				_update_sprite()
				_clickable = true
				_shared_data.open_tiles.erase(self)
	
func _update_sprite():
	if _state == "closed":
		$Sprite.region_rect.position.x = 0
	else:
		$Sprite.region_rect.position.x = tile * 64
		

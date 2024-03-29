extends Button

var Data = preload("res://scripts/Data.gd").new()
const Entity = preload("res://scenes/entities/Entity.tscn")

var data # dictionary eg. {"up": 8, ...}
var self_owner # Turn.Player or Turn.Opponent

var _clickable = true
var _entity # Entity instance
var _original_colour

export var board_x = -1
export var board_y = -1

signal pressed_who
signal entity_placed

func set_entity(data, self_owner):
	# Change into an entity. No longer clickable.
	self.data = data
	self.self_owner = self_owner
	self._original_colour = self_owner
	self._clickable = false
	self._entity = Entity.instance()
	self._entity.init(data)
	self.add_child(self._entity)
	self.emit_signal("entity_placed", Vector2(self.board_x, self.board_y), self.data)

func change_colour(new_owner, initializing = false):
	var flip = false
	
	if Features.ENABLE_LIFE_POINTS:
		if not initializing and self.data["lp"] > 0:
			if new_owner != self._original_colour:
				self.data["lp"] -= 1
				self._entity.update_lp(self.data["lp"])
			flip = true
		elif initializing:
			flip = true
	elif initializing or (new_owner != self._original_colour):
		flip = true
		
	if flip:
		self.self_owner = new_owner
		self._entity.change_colour(new_owner)
	
	return flip

func consume():
	self.remove_child(self._entity)

func resize_margins(x:int, y:int):
	self.margin_left = x
	self.margin_right = self.margin_left + Constants.CARD_WIDTH
	self.margin_top = y
	self.margin_bottom = self.margin_top + Constants.CARD_HEIGHT


func _on_Button_pressed():
	self.emit_signal("pressed_who", self)

# convenience method, breaks OOP sorta
func get_capture_points():
	return self.data["capture_points"]

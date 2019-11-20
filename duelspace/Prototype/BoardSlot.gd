extends Button

var Data = preload("res://Prototype/Data.gd").new()
const Entity = preload("res://Prototype/Entity.tscn")

var data # dictionary eg. {"up": 8, ...}
var slot_owner # Turn.Player or Turn.Opponent

var _clickable = true
var _entity # Entity instance

export var board_x = -1
export var board_y = -1

signal pressed_who
signal entity_placed

func set_entity(data, slot_owner):
	# Change into an entity. No longer clickable.
	self.data = data
	self.slot_owner = slot_owner
	self._clickable = false
	self._entity = Entity.instance()
	self._entity.init(data)
	self.add_child(self._entity)
	self.emit_signal("entity_placed", Vector2(self.board_x, self.board_y), self.data)
	

func change_colour(owner):
	self.slot_owner = owner
	self._entity.change_colour(owner)

func consume():
	self.remove_child(self._entity)

func _on_Button_pressed():
	self.emit_signal("pressed_who", self)

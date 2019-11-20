extends Node2D

signal board_clicked

func _ready():
	# Stop trying to be so clever.
	var children = self.get_children()
	for node in children:
		if node.name.find("Slot") > -1:
			node.connect("pressed_who", self, "_on_slot_pressed")
			node.connect("entity_placed", self, "_on_entity_placed")

func _on_slot_pressed(slot):
	self.emit_signal("board_clicked", slot)
	
func _on_entity_placed(coordinates, entity_data):
	var my_owner = self._get_slot(coordinates.x, coordinates.y).slot_owner
	var above_slot = self._get_slot(coordinates.x, coordinates.y - 1)
	var left_slot = self._get_slot(coordinates.x - 1, coordinates.y)
	var below_slot = self._get_slot(coordinates.x, coordinates.y + 1)
	var right_slot = self._get_slot(coordinates.x + 1, coordinates.y)
	
	if above_slot != null and above_slot.slot_owner != my_owner and above_slot.data != null and above_slot.data["down"] < entity_data["up"]:
		above_slot.change_colour(my_owner)
	if left_slot != null and left_slot.slot_owner != my_owner and left_slot.data != null and left_slot.data["right"] < entity_data["left"]:
		left_slot.change_colour(my_owner)
	if below_slot != null and below_slot.slot_owner != my_owner and below_slot.data != null and below_slot.data["up"] < entity_data["down"]:
		below_slot.change_colour(my_owner)
	if right_slot != null and right_slot.slot_owner != my_owner and right_slot.data != null and right_slot.data["left"] < entity_data["right"]:
		right_slot.change_colour(my_owner)
	
func _get_slot(x, y):
	# Returns null if doesn't exist
	return self.get_node("Slot" + str(x) + str(y))
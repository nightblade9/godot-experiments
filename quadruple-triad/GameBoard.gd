extends Node2D

signal board_clicked
signal points_earned

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
	
	var was_changed = false
	var capture_points = 0
	
	if above_slot != null and above_slot.slot_owner != my_owner and above_slot.data != null and above_slot.data["down"] < entity_data["up"]:
		was_changed = above_slot.change_colour(my_owner)
		capture_points = above_slot.get_capture_points()
	if left_slot != null and left_slot.slot_owner != my_owner and left_slot.data != null and left_slot.data["right"] < entity_data["left"]:
		was_changed = left_slot.change_colour(my_owner)
		capture_points = left_slot.get_capture_points()
	if below_slot != null and below_slot.slot_owner != my_owner and below_slot.data != null and below_slot.data["up"] < entity_data["down"]:
		was_changed = below_slot.change_colour(my_owner)
		capture_points = below_slot.get_capture_points()
	if right_slot != null and right_slot.slot_owner != my_owner and right_slot.data != null and right_slot.data["left"] < entity_data["right"]:
		was_changed = right_slot.change_colour(my_owner)
		capture_points = right_slot.get_capture_points()
	
	if was_changed:
		self.emit_signal("points_earned", capture_points)
	
func _get_slot(x, y):
	# Returns null if doesn't exist
	return self.get_node("Slot" + str(x) + str(y))

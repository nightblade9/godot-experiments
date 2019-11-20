extends Node2D

var selected_card
var is_opponent
var _cards

signal card_picked

func init(cards, owner):
	self._cards = cards
	self.is_opponent = is_opponent
	
	for i in range(len(cards)):
		var card = cards[i]
		var control_name = "Slot" + str(i+1)
		var slot = self.get_node(control_name)
		slot.set_entity(card, owner)
		slot.connect("pressed_who", self, "_on_slot_pressed")
		
		slot.change_colour(owner)

func consume(card):
	var index = self._cards.find(card)
	self._cards[index] = null # removes from inventory/etc.
	var control_name = "Slot" + str(index + 1)
	var slot = self.get_node(control_name)
	slot.consume()
	self.selected_card = null

func _on_slot_pressed(slot):
	self.selected_card = slot.data
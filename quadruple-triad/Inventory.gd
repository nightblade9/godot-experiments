extends Node2D

const Slot = preload("res://BoardSlot.tscn")

var selected_card
var is_opponent
var _cards

signal card_picked

func init(cards, owner):
	self._cards = cards
	self.is_opponent = is_opponent
	
	for i in range(len(cards)):
		var card = cards[i]
		var slot = Slot.instance()
		add_child(slot)
		slot.set_entity(card, owner)
		slot.connect("pressed_who", self, "_on_slot_pressed")
		slot.change_colour(owner, true)
		
		# TWo columns
		var x = 0 if i < 5 else Constants.CARD_WIDTH
		var y = i * Constants.CARD_HEIGHT if i < 5 else (i-5) * Constants.CARD_HEIGHT

		slot.resize_margins(x, y) 

func consume(card):
	var index = self._cards.find(card)
	self._cards[index] = null # removes from inventory/etc.
	var control_name = "Slot" + str(index + 1)
	var slot = self.get_node(control_name)
	slot.consume()
	self.selected_card = null

func _on_slot_pressed(slot):
	self.selected_card = slot.data

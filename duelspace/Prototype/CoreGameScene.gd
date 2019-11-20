extends Node2D

var Data = preload("res://Prototype/Data.gd").new()
var Turn = preload("res://Prototype/Turn.gd")

const NUM_CARDS = 5

var _player_cards = []
var _opponent_cards = []
var _current_turn = Turn.Turn.Player

func _ready():
	self._pick_cards_into(_player_cards)
	self._pick_cards_into(_opponent_cards)
	
	$PlayerInventory.init(_player_cards, Turn.Turn.Player)
	$OpponentInventory.init(_opponent_cards, Turn.Turn.Opponent)
	$Board.connect("board_clicked", self, "_try_to_play_turn")
	
func _pick_cards_into(cards):
	while len(cards) < NUM_CARDS:
		# dupes are fine
		var card = Data.ALL_CARDS[randi() % len(Data.ALL_CARDS)]
		cards.append(card)

func _try_to_play_turn(slot):
	if slot.data == null: # Clicked empty slot
	
		var target_card
		var owning_inventory
		
		if _current_turn == Turn.Turn.Player:
			target_card = $PlayerInventory.selected_card
			owning_inventory = $PlayerInventory
		else:
			target_card = $OpponentInventory.selected_card
			owning_inventory  = $OpponentInventory
		
		if target_card != null:
			owning_inventory.consume(target_card)
			slot.set_entity(target_card, self._current_turn)
			slot.change_colour(_current_turn)
			
			self._rotate_turn()
			$PlayerInventory.selected_card = null
			$OpponentInventory.selected_card = null

func _rotate_turn():
	if self._current_turn == Turn.Turn.Player:
		self._current_turn = Turn.Turn.Opponent
	else:
		self._current_turn = Turn.Turn.Player
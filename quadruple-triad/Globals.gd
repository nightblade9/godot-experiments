extends Node

const CARD_WIDTH = 130
const CARD_HEIGHT = 150
const BOARD_WIDTH:int = 4
const BOARD_HEIGHT:int = 4

# TODO: move to features
const ENABLE_LIFE_POINTS = false
const ENABLE_CAPTURE_POINTS = false

func _ready():
	randomize()

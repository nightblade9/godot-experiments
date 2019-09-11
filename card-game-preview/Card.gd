tool
extends Node2D

export var Creature:String setget set_creature, get_creature
var _creature:String = ""

const ALL_CARDS_STATS = {
	"Banana": [3, 3],
	"Brain": [5, 3],
	"Duck": [3, 4],
	"Giraffe": [5, 2],
	"Hamster": [2, 3],
	"Jellyfish": [5, 3],
	"Mushroom": [4, 2],
	"Orange": [3, 3],
	"Star": [2, 4],
	"Sword": [4, 2]
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_creature(value):
	_creature = value
	$Character.texture = load("res://Assets/" + value + ".png")
	var data = ALL_CARDS_STATS[value]
	$Control/StrengthLabel.text = "+" + str(data[0])
	$Control/HealthLabel.text = str(data[1])

func get_creature():
	return _creature;
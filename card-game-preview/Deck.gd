tool
extends Node2D

export var Card1:String setget set_card1, get_card1
export var Card2:String setget set_card2, get_card2
export var Card3:String setget set_card3, get_card3

var cards = ["Banana", "Orange", "Star"]

func set_card1(value):
	cards[0] = value
	$C1.Creature = value
func get_card1():
	return cards[0]
	
func set_card2(value):
	cards[1] = value
	$C2.Creature = value
func get_card2():
	return cards[1]
	
func set_card3(value):
	cards[2] = value
	$C3.Creature = value
func get_card3():
	return cards[2]
	
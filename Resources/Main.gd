extends Node2D

const MonsterData = preload("res://MonsterData.gd")

func _ready():
	var temp = ResourceLoader.load("res://MonsterData.gd")
	# Intellisense!!!!11one
	print("Whoa: slime HP is %s" % MonsterData.Data.Slime.HP)
	

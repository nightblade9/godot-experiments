extends Node2D

# Cards where sum=20 and average=5

var _BALANCED_CARDS = [
#	make_card("Goblin", 1, 2, 8, 9, 2),
#	make_card("Elf", 8, 9, 1, 2, 3),
#	make_card("Knight", 5, 5, 5, 5, 2),
#	make_card("Cactrot", 7, 3, 7, 3, 2),
#	make_card("Pyro", 1, 9, 1, 9, 1),
#	make_card("Commander", 8, 3, 6, 3, 2),
#	make_card("Queen", 5, 6, 4, 5, 2),
#	make_card("King", 6, 4, 6, 4, 2),
#	make_card("Ballista", 8, 8, 2, 2, 3),
#	make_card("Dragon", 2, 5, 7, 6, 3)
]

# Cards ranging from weaker (16) to stronger (25) points
var ALL_CARDS = [
	# ordered from weakest to strongest (16-25 points, +1 on each card)
	make_card("Goblin", 1, 2, 6, 7,		2), # 16 points
	make_card("Elf", 7, 8, 1, 1,		3),
	make_card("Knight", 5, 4, 5, 4,		2),
	make_card("Cactrot", 7, 3, 7, 2,	2),
	make_card("Pyro", 1, 9, 1, 9,		1),
	make_card("Commander", 8, 4, 6, 3,	2),
	make_card("Queen", 5, 7, 5, 5,		2),
	make_card("King", 7, 6, 6, 4,		2),
	make_card("Ballista", 8, 8, 4, 4,	3),
	make_card("Dragon", 3, 6, 9, 7,		3) # 25 points
]

func make_card(name, up, right, down, left, life_points):
	#var max_stat = max(up, max(right, max(down, left)))
	#var min_stat = min(up, min(down, min(right, left)))
	#var capture_points = min_stat # as strong as the weakest link
	
	# Sort of average. Gives a nice, normal distro (55 666 777 88)
	var capture_points = (up+right+down+left)/3
	
	return { 
		"name": name,
		"up": up, "right": right, "down": down, "left": left,
		"lp": life_points, "capture_points": capture_points
	}
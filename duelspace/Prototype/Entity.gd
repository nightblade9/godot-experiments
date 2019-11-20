extends Node2D

const Turn = preload("res://Prototype/Turn.gd")

const OPPONENT_COLOUR = Color(0.5, 0, 0)
const PLAYER_COLOUR = Color(0, 0.25, 0.5)

const _SPRITES = {
	"Dragon": Vector2(480, 96),
	"Knight": Vector2(576, 0),
	"Goblin": Vector2(0, 192),
	"Elf": Vector2(0, 0),
	"Commander": Vector2(288, 576),
	"Cactrot": Vector2(0, 768),
	"Pyro": Vector2(672, 480),
	"Queen": Vector2(0, 480),
	"King": Vector2(192, 480),
	"Ballista": Vector2(288, 672)
}

func init(data):
	$Up.text = str(data["up"])
	$Right.text = str(data["right"])
	$Down.text = str(data["down"])
	$Left.text = str(data["left"])
	$Sprite.region_rect.position = _SPRITES[data["name"]]

func change_colour(owner):
	if owner == Turn.Turn.Opponent:
		$ColorRect.color = OPPONENT_COLOUR
	else:
		$ColorRect.color = PLAYER_COLOUR
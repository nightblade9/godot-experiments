extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Antigravity_body_entered(body):
	if body == $Player:
		$Player.touching_antigrav = true


func _on_Antigravity_body_exited(body):
	if body == $Player:
		$Player.touching_antigrav = false


func _on_Area2D_body_entered(body):
	self.get_tree().reload_current_scene()

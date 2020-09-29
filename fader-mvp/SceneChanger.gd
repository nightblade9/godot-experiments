extends CanvasLayer

const FadeScene = preload("res://FadeScene.tscn")
const Player = preload("res://Player.tscn")
const PlayerScript = preload("res://Player.gd")

const FADE_DURATION_SECONDS = 1

var _current_scene = null

func _ready():
	var root = get_tree().root
	_current_scene = root.get_child(root.get_child_count() - 1)

func change_scene(target_scene:String):
	
	var root = get_tree().root
	var screenshot:Sprite = take_screenshot()
	
	var fade_scene = FadeScene.instance()
	var sprite = fade_scene.get_node("Sprite")
	sprite.texture = screenshot.texture
	root.add_child(fade_scene)
	
	var new_scene = _set_scene(target_scene)
	# Dispose old scene so we don't get any camera jitters or wierdness.
	# Current scene is null when we launch the game from Main.tscn
	if  _current_scene != null:
		root.remove_child(_current_scene)
		_current_scene.queue_free()
	
	var player = Player.instance()
	new_scene.add_child(player)
	
	# wait for shader fade to complete
	fade_scene.start()
	yield(fade_scene, "fade_done")
		
	root.remove_child(fade_scene)
	_current_scene = new_scene

func _set_scene(target_scene:String):
	var new_scene = load(target_scene).instance()
	get_tree().root.add_child(new_scene)
	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(new_scene)
	return new_scene
	
func take_screenshot():
	var image:Image = get_tree().get_root().get_texture().get_data()
	# Flip it on the y-axis (because it's flipped)
	image.flip_y()
	
	var image_texture = ImageTexture.new()
	image_texture.create_from_image(image)
	image_texture.flags = 0 # turn off "Filter"

	var sprite = Sprite.new()
	sprite.texture = image_texture
	sprite.centered = false
	
	return sprite


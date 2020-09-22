extends CanvasLayer

var _current_scene = null
const FADE_TIME = 1

func _ready():
	var root = get_tree().root
	_current_scene = root.get_child(root.get_child_count() - 1)

func change_scene(target_scene:String):
	call_deferred("_deferred_change_scene", target_scene)

func _deferred_change_scene(target_scene:String):
	var new_scene = _set_scene(target_scene)
	
	var tweeny = Tween.new()
	add_child(tweeny)
	tweeny.interpolate_property(new_scene, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), FADE_TIME)
	tweeny.start()
	yield(tweeny, "tween_completed")
	
	_current_scene.free()	
	_current_scene = new_scene

func _set_scene(target_scene:String):
	var new_scene = ResourceLoader.load(target_scene).instance()
	get_tree().root.add_child(new_scene)
	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(new_scene)
	return new_scene

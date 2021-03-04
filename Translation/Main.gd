extends Node2D

func _on_Button_pressed():
	_change_language("en_US")
	$Label.text = tr("HELLO")


func _on_Button2_pressed():
	_change_language("ar_SA")
	$Label.text = tr("HELLO")
	
func _change_language(language):
	TranslationServer.set_locale(language)

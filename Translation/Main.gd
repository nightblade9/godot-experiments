extends Node2D

var _times_clicked:int = 0

func _on_Button_pressed():
	_times_clicked += 1
	_change_language("en_US")
	$Label.text = tr("HELLO") % _times_clicked


func _on_Button2_pressed():
	_times_clicked += 1	
	_change_language("ar_SA")
	$Label.text = tr("HELLO") % _times_clicked
	
func _change_language(language):
	TranslationServer.set_locale(language)

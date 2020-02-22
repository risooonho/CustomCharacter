extends Control



func _on_New_pressed() -> void:
	get_tree().change_scene("res://CustomCharacter/CustomCharacter.tscn")


func _on_Exit_pressed() -> void:
	get_tree().quit()

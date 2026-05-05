extends Control



func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://CENAS/florestaSubtracao.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_tuto_pressed() -> void:
	get_tree().change_scene_to_file("res://CENAS/tutorial.tscn")

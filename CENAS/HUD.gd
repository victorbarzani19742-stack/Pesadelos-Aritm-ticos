extends CanvasLayer
signal restart

func show_game_over():
	visible = true
	$Message.text = "Você perdeu"
	$Leave.visible = true
	$Button.visible = true
	$Sprite2D.visible = false

func show_victory():
	visible = true
	$Message.text = "Você venceu!"
	$Button.visible = true
	$Sprite2D.visible = true
	$Leave.visible = true
	$Sprite2D.visible = true

func hide_game_ui():
	visible = false

func _on_button_pressed() -> void:
	hide_game_ui()
	get_tree().change_scene_to_file("")


func _on_leave_pressed() -> void:
	get_tree().quit()

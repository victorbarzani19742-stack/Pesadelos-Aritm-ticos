extends CanvasLayer

@onready var texture_rect = $TextureRect
@onready var label = $Label
@onready var restart_button = $VBoxContainer/Restart
@onready var quit_button = $VBoxContainer/Quit

var victory_texture = preload("res://ASSESTS/HUD/ChatGPT Image 10 de nov. de 2025, 19_18_47.png")
var defeat_texture = preload("res://ASSESTS/HUD/ChatGPT Image 10 de nov. de 2025, 19_18_21.png")

func show_game_over():
	visible = true
	
	texture_rect.texture = defeat_texture
	texture_rect.expand = true
	texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	texture_rect.modulate.a = 1.0  

	label.text = "Você Perdeu!!!\nNão Conseguiu realizar a Prova"
	label.add_theme_color_override("font_color", Color.RED)
	label.add_theme_color_override("font_outline_color", Color.BLACK) 
	label.add_theme_constant_override("outline_size", 4)               

	restart_button.visible = true
	quit_button.visible = true


func show_victory():
	visible = true
	
	texture_rect.texture = victory_texture
	texture_rect.expand = true
	texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	texture_rect.modulate.a = 1.0

	label.text = "Você venceu!\nConsegui Realizar a Prova!"
	label.add_theme_color_override("font_color", Color(0, 1, 0))
	label.add_theme_color_override("font_outline_color", Color.BLACK) 
	label.add_theme_constant_override("outline_size", 3)              

	restart_button.visible = true
	quit_button.visible = true


func hide_game_over():
	visible = false
	texture_rect.modulate.a = 0.0


func _on_restart_pressed():
	hide_game_over()
	get_tree().change_scene_to_file("res://CENAS/menu.tscn")


func _on_quit_pressed():
	get_tree().quit()

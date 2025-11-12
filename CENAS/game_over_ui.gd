extends CanvasLayer

@onready var texture_rect = $TextureRect
@onready var label = $Label
@onready var restart_button = $VBoxContainer/Restart
@onready var quit_button = $VBoxContainer/Quit

var victory_texture = preload("res://ASSESTS/HUD/Imagem do WhatsApp de 2025-11-10 à(s) 19.19.05_b1116cc1.jpg")
var defeat_texture  = preload("res://ASSESTS/HUD/Imagem do WhatsApp de 2025-11-10 à(s) 19.18.48_f26f8d29.jpg")


# ----------------------------
# EXIBIR GAME OVER
# ----------------------------
func show_game_over():
	visible = true

	label.text = "Você Perdeu!!!\nNão Conseguiu realizar a Prova"
	label.add_theme_color_override("font_color", Color.RED)
	label.add_theme_color_override("font_outline_color", Color.BLACK)
	label.add_theme_constant_override("outline_size", 4)

	texture_rect.texture = defeat_texture
	texture_rect.expand = true
	texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	texture_rect.modulate.a = 1.0

	restart_button.visible = true
	quit_button.visible = true


# ----------------------------
# EXIBIR VITÓRIA
# ----------------------------
func show_victory():
	visible = true

	texture_rect.texture = victory_texture
	texture_rect.expand = true
	texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	texture_rect.modulate.a = 1.0

	restart_button.visible = true
	quit_button.visible = true


# ----------------------------
# LIMPAR E ESCONDER O PAINEL
# ----------------------------
func hide_game_over():
	visible = false
	texture_rect.modulate.a = 0.0


# ----------------------------
# BOTÃO: RESTART
# ----------------------------
func _on_restart_pressed():
	hide_game_over()
	get_tree().change_scene_to_file("res://CENAS/menu.tscn")


# ----------------------------
# BOTÃO: QUIT
# ----------------------------
func _on_quit_pressed():
	get_tree().quit()

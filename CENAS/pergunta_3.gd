extends Control

var tempo_restante = 60

@onready var label_timer = $LabelTimer
@onready var timer = $Timer

func _ready():
	tempo_restante = 60
	atualizar_timer()
	timer.start()

func _on_timer_timeout() -> void:
	tempo_restante -= 1
	atualizar_timer()

	if tempo_restante <= 0:
		timer.stop()
		GameOverUi.show_game_over()

func atualizar_timer():
	label_timer.text = "⏳ Tempo: " + str(tempo_restante)

func _on_button_pressed() -> void:
	GameOverUi.show_game_over()


func _on_button_2_pressed() -> void:
	GameOverUi.show_game_over()


func _on_button_3_pressed() -> void:
	GameOverUi.show_game_over()


func _on_button_4_pressed() -> void:
	get_tree().change_scene_to_file("res://CENAS/caverna.tscn")

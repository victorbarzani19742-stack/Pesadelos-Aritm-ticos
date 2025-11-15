extends Area2D

@onready var victory_sound = $AudioStreamPlayer2D

func _on_body_entered(body):
	if body is Aluno:
		victory_sound.play()
		GameOverUi.show_victory()
		

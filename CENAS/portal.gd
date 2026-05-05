extends Area2D

@export var cena_alvo: String = "res://CENAS/pergunta_1.tscn"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Aluno":
		call_deferred("_mudar_de_fase")

func _mudar_de_fase() -> void:
	get_tree().change_scene_to_file(cena_alvo)

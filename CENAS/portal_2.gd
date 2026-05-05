extends Area2D


@export var cena_alvo: String = "res://CENAS/aurora.tscn"





func _on_body_entered(body: Node2D) -> void:
	if body.name == "Aluno": 
		get_tree().change_scene_to_file("res://CENAS/pergunta_2.tscn"	)

extends Camera2D

@export var target_path: NodePath
@export var follow_speed := 5.0
@export var camera_offset := Vector2(0, 0) # deslocamento opcional da câmera

var target: Node2D

func _ready():
	# Define o alvo (personagem)
	if target_path:
		target = get_node(target_path)
	enabled = true  # ativa esta câmera

func _process(delta):
	if target:
		# Move suavemente a câmera em direção ao personagem
		var target_pos = target.global_position + camera_offset
		global_position = lerp(global_position, target_pos, follow_speed * delta)

extends Camera2D

@export var target_path: NodePath
@export var follow_speed := 5.0
@export var camera_offset := Vector2(0, 0) 

var target: Node2D

func _ready():
	
	if target_path:
		target = get_node(target_path)
	enabled = true  

func _process(delta):
	if target:
		
		var target_pos = target.global_position + camera_offset
		global_position = lerp(global_position, target_pos, follow_speed * delta)

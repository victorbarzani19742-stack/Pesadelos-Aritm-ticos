extends Area2D

@export var h_speed := 30.0
@export var v_speed := 120.0
@export var bounce_force := -300.0

@onready var ray_cast := $RayCast2D
@onready var anim := $AnimatedSprite2D
@onready var notifier := $VisibleOnScreenNotifier2D

var dead := false


func _ready():
	anim.play("walk")


func _process(delta):
	if dead:
		return
	
	# Anda pra esquerda infinitamente
	position.x -= h_speed * delta

	# Se não detectar chão → cai
	if not ray_cast.is_colliding():
		position.y += v_speed * delta


# Player encostou
func _on_body_entered(body):
	if dead:
		return
	
	# Se o player bateu por cima
	if "is_falling" in body and body.is_falling():
		_die_from_hit()
		body.velocity.y = bounce_force
	else:
		if "die" in body:
			body.die()
			print("Colidiu com: ", body)


# Morte normal (quando player bate por cima)
func _die_from_hit():
	dead = true
	h_speed = 0
	v_speed = 0
	rotation_degrees = 180
	$AudioStreamPlayer2D.play()
	set_collision_layer_value(3, false)
	set_collision_mask_value(1, false)

	$CollisionShape2D.disabled = true
	ray_cast.enabled = false

	var tw = create_tween()
	tw.tween_property(self, "position", position + Vector2(0, -20), 0.2)
	tw.chain().tween_property(self, "modulate:a", 0.0, 0.5)
	tw.chain().tween_callback(queue_free)

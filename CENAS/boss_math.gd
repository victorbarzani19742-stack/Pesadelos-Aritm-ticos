extends Node2D

# --- NÓS DA CENA ---
@onready var label_number = $Label
@onready var button1 = $Button_Option1
@onready var button2 = $Button_Option2
@onready var sfx = $AudioStreamPlayer
@onready var anim = $AnimationPlayer
@onready var timer_attack = $Timer_Attack
@onready var life_bar = $ProgressBar_Life
@onready var label_score = $Label_Score
@onready var victory_sound = $AudioStreamPlayer2D

# Game Over UI (defina no Inspector)
@export var game_over_ui: Node

# Variáveis do jogo
var correct_answer = 0
var difficulty_level = 1
var boss_life = 5
var is_waiting_answer = false

var score = 0
var combo = 0


func _ready():
	randomize()

	if game_over_ui == null:
		print("⚠ AVISO: GameOverUi não definido no Inspector!")

	timer_attack.connect("timeout", Callable(self, "_on_timer_attack_timeout"))

	life_bar.max_value = boss_life
	life_bar.value = boss_life

	label_score.text = "Score: 0 | Combo: 0x"

	start_boss_turn()


# -----------------------------------------------------------
# TURNO DO BOSS
# -----------------------------------------------------------
func start_boss_turn():
	button1.visible = false
	button2.visible = false
	label_number.text = ""
	is_waiting_answer = false

	anim.play("idle")

	var target = randi_range(5 * difficulty_level, 15 * difficulty_level)
	correct_answer = target

	label_number.modulate.a = 0.0
	label_number.text = str(target)

	if sfx:
		sfx.play()

	anim.play("summon")

	var tween = create_tween()
	tween.tween_property(label_number, "modulate:a", 1.0, 1.0)
	tween.tween_callback(Callable(self, "_on_number_invoked"))


func _on_number_invoked():
	generate_equations(correct_answer)

	button1.visible = true
	button2.visible = true

	is_waiting_answer = true

	timer_attack.wait_time = max(2.0, 6.0 - difficulty_level * 0.5)
	timer_attack.start()


# -----------------------------------------------------------
# GERAR EQUAÇÕES
# -----------------------------------------------------------
func generate_equations(target):
	var correct_equation = generate_random_equation(target)
	var wrong_equation = ""

	while true:
		wrong_equation = generate_random_equation(target + randi_range(-5, 5))
		if eval_equation(wrong_equation) != target:
			break

	if randf() < 0.5:
		set_button(button1, correct_equation, true)
		set_button(button2, wrong_equation, false)
	else:
		set_button(button1, wrong_equation, false)
		set_button(button2, correct_equation, true)


func set_button(button: Button, text: String, is_correct: bool):
	button.text = text
	button.set_meta("is_correct", is_correct)


func generate_random_equation(result: int) -> String:
	var ops = ["+", "-", "*", "/"]
	var available_ops = ops.slice(0, clamp(1 + difficulty_level, 1, 4))
	var op = available_ops.pick_random()

	var a
	var b

	match op:
		"+": 
			a = randi_range(1, result - 1)
			b = result - a

		"-":
			a = result + randi_range(1, 10)
			b = a - result

		"*":
			var factors = get_factors(result)
			if factors.size() >= 2:
				a = factors.pick_random()
				b = result / a
			else:
				return generate_random_equation(result)

		"/":
			b = randi_range(1, 10)
			a = result * b

	return "%d %s %d" % [a, op, b]


func get_factors(n: int) -> Array:
	var f = []
	for i in range(1, n + 1):
		if n % i == 0:
			f.append(i)
	return f


func eval_equation(eq: String) -> float:
	var p = eq.split(" ")
	if p.size() < 3:
		return 0.0

	var a = float(p[0])
	var op = p[1]
	var b = float(p[2])

	match op:
		"+": return a + b
		"-": return a - b
		"*": return a * b
		"/":
			if b == 0:
				return 0.0
			return a / b

	return 0.0


# -----------------------------------------------------------
# RESPOSTA
# -----------------------------------------------------------
func check_answer(button: Button):
	is_waiting_answer = false
	timer_attack.stop()

	if button.get_meta("is_correct"):
		combo += 1
		score += 100 * combo
		update_score()
		boss_take_damage()
	else:
		_game_over()


func update_score():
	label_score.text = "Score: %d | Combo: %dx" % [score, combo]


# -----------------------------------------------------------
# HIT NO BOSS
# -----------------------------------------------------------
func boss_take_damage():
	anim.play("hurt")
	boss_life -= 1
	life_bar.value = boss_life

	if boss_life <= 0:
		boss_die()
		return

	await get_tree().create_timer(1.0).timeout
	difficulty_level += 1
	start_boss_turn()


# -----------------------------------------------------------
# MORTE DO BOSS
# -----------------------------------------------------------
func boss_die():
	anim.play("die")

	label_number.text = ""
	button1.visible = false
	button2.visible = false
	label_score.text += "  FINAL!"

	if victory_sound:
		victory_sound.play()

	await get_tree().create_timer(1.2).timeout

	if game_over_ui:
		game_over_ui.show_victory()
	else:
		print("ERRO: GameOverUi não encontrado.")


# -----------------------------------------------------------
# BOTÕES
# -----------------------------------------------------------
func _on_button_option_1_pressed():
	if is_waiting_answer:
		check_answer(button1)

func _on_button_option_2_pressed():
	if is_waiting_answer:
		check_answer(button2)


# -----------------------------------------------------------
# TIMER
# -----------------------------------------------------------
func _on_timer_attack_timeout():
	if is_waiting_answer:
		_game_over()


# -----------------------------------------------------------
# GAME OVER
# -----------------------------------------------------------
func _game_over():
	if game_over_ui:
		game_over_ui.show_game_over()
	else:
		print("ERRO: GameOverUi não definido!")

extends CharacterBody2D

@export var speed: float = 200.0
@export var sprint_speed: float = 320.0
@export var sprint_time: float = 0.6
@export var think_time: float = 0.8

var direction = Vector2.ZERO
var revealed_timer: float = 0.0
var tagged: bool = False

onready var sprite: Sprite2D = $Sprite2D
onready var reveal: ColorRect = $Reveal
onready var tag_audio: AudioStreamPlayer = $TagAudio

func _ready():
	add_to_group("runners")
	_choose_direction()

func _physics_process(delta):
	if tagged:
		velocity = Vector2.ZERO
	else:
		velocity = direction * speed
		move_and_slide()
	
	# simple boundary reflection
	if position.x < 80 or position.x > 1840:
		direction.x *= -1
	if position.y < 140 or position.y > 1000:
		direction.y *= -1
	
	# decay reveal ping effect
	if revealed_timer > 0:
		revealed_timer -= delta
		reveal.visible = true
	else:
		reveal.visible = false

func _choose_direction():
	var ang = randf() * TAU
	direction = Vector2(cos(ang), sin(ang)).normalized()

func _on_Think_timeout():
	_choose_direction()

func get_tagged():
	if tagged: return
	tagged = true
	tag_audio.play()
	sprite.modulate = Color(0.5,0.5,0.5,1.0)
	set_process(false)
	set_physics_process(false)
	$Reveal.visible = true

func reveal_ping():
	revealed_timer = 1.5
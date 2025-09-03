extends CharacterBody2D

@export var speed: float = 260.0
@export var tag_radius: float = 80.0
@export var ping_cooldown: float = 3.0

var ping_ready: bool = true
var nearest_dist: float = 99999.0

onready var sprite: Sprite2D = $Sprite2D
onready var area: Area2D = $TagArea
onready var proximity_timer: Timer = $ProximityTimer
onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
onready var ping_audio: AudioStreamPlayer = $PingAudio

func _physics_process(_delta):
	var input_vector = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).normalized()
	velocity = input_vector * speed
	move_and_slide()
	
	# Rotate to face movement
	if input_vector.length() > 0.01:
		sprite.rotation = input_vector.angle()
	
	# Ping ability
	if Input.is_action_just_pressed("ping") and ping_ready:
		ping_ready = false
		ping_audio.play()
		get_tree().call_group("runners", "reveal_ping")
		get_tree().create_timer(ping_cooldown).timeout.connect(func(): ping_ready = true)

func _on_TagArea_body_entered(body):
	if body.is_in_group("runners"):
		body.get_tagged()

func update_proximity(dist: float):
	nearest_dist = dist

func _on_ProximityTimer_timeout():
	# Beep based on nearest runner distance
	if nearest_dist < 90:
		audio_player.stream = preload("res://assets/beep_close.wav")
		audio_player.volume_db = -2
	elif nearest_dist < 200:
		audio_player.stream = preload("res://assets/beep_mid.wav")
		audio_player.volume_db = -4
	elif nearest_dist < 420:
		audio_player.stream = preload("res://assets/beep_far.wav")
		audio_player.volume_db = -6
	else:
		return
	audio_player.play()
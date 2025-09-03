extends Node2D

@export var arenas := [
	"res://assets/bg_village.png",
	"res://assets/bg_school.png",
	"res://assets/bg_rooftop.png"
]

var arena_index := 0

onready var bg: Sprite2D = $Background
onready var player: Node2D = $Player
onready var runners: Node = $Runners
onready var info: Label = $CanvasLayer/Info
onready var next_button: TextureButton = $CanvasLayer/NextButton
onready var ping_button: TextureButton = $CanvasLayer/PingButton

func _ready():
	_load_arena(0)
	$StartSound.play()

func _process(_delta):
	_update_proximity_beep()

func _update_proximity_beep():
	var nearest := 99999.0
	for r in runners.get_children():
		if not r.tagged:
			var d = player.position.distance_to(r.position)
			if d < nearest:
				nearest = d
	player.update_proximity(nearest)

func _on_NextButton_pressed():
	arena_index = (arena_index + 1) % arenas.size()
	_load_arena(arena_index)

func _on_PingButton_pressed():
	Input.parse_input_event(InputEventKey.new())
	# Simulate Q press for on-screen button
	player.ping_ready = true
	Input.action_press("ping")
	Input.action_release("ping")

func _load_arena(idx: int):
	bg.texture = load(arenas[idx])
	info.text = "Arena: %d/%d  |  Tag the three runners!  Move: WASD/Arrows, Ping: Q" % [idx+1, arenas.size()]
	_reset_round()

func _reset_round():
	# reset players and runners
	player.position = Vector2(640, 360)
	var spots = [Vector2(1000,300), Vector2(1200,700), Vector2(300,900)]
	var i := 0
	for r in $Runners.get_children():
		r.position = spots[i]
		r.tagged = false
		r.sprite.modulate = Color(1,1,1,1)
		r.set_process(true)
		r.set_physics_process(true)
		r.revealed_timer = 0.0
		r.$Reveal.visible = false
		i += 1
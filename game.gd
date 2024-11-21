extends Node2D

@onready var top: StaticBody2D = $top
@onready var top_collision: CollisionShape2D = $top/CollisionShape2D
@onready var bottom: StaticBody2D = $bottom
@onready var bottom_collision: CollisionShape2D = $bottom/CollisionShape2D
@onready var ball: CharacterBody2D = $ball

@onready var ai_score_label: Label = $UI/HBoxContainer/ai_score
@onready var player_score_label: Label = $UI/HBoxContainer/player_score

func _ready() -> void:
	$ball.position = $spawn_point.position
	$start_timer.timeout.connect(ball.go)
	
func _process(_delta: float) -> void:
	ai_score_label.text = str(GameState.ai_score)
	player_score_label.text = str(GameState.player_score)

func reset() -> void:
	$ball.position = $spawn_point.position
	$player_paddle.position = Vector2(1248, 360)
	$ai_paddle.position = Vector2(32, 360)
	$start_timer.start(3.0)

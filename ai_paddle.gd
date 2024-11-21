extends CharacterBody2D

@export var MAX_SPEED = 500.0

@export var width := 10.0
@export var height := 200.0
@onready var ball: CharacterBody2D = $"../ball"

func _ready() -> void:
	_calculate_shape()

func _physics_process(delta: float) -> void:
	_calculate_shape()
	
	if GameState.game_started:
		var distance := abs(ball.position.y - position.y) as float
		if distance > 50.0:
			velocity = position.direction_to(Vector2(position.x, ball.position.y)) * 100.0
		move_and_collide(velocity * delta)

func _calculate_shape() -> void:
	if not is_inside_tree():
		return
	
	var size := Vector2(width, height)
	var shape := $CollisionShape2D.shape as RectangleShape2D
	shape.size = size
	
	$ColorRect.position = Vector2(-size.x / 2.0, -size.y / 2.0)
	$ColorRect.size = size
	$ColorRect.color = Color.WHITE

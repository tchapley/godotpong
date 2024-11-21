extends CharacterBody2D

const MAX_SPEED = 600.0

@export var width := 10.0
@export var height := 200.0

func _ready() -> void:
	_calculate_shape()

func _physics_process(delta: float) -> void:
	_calculate_shape()
	
	if GameState.game_started:
		var direction := Input.get_axis("ui_up", "ui_down")
		velocity.x = 0.0
		velocity.y = direction * MAX_SPEED
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

extends CharacterBody2D
class_name Ball

@export var START_SPEED = 600.0

@export var width := 20.0
@export var height := 20.0

func _ready() -> void:
	randomize()
	velocity = Vector2.ZERO
	_calculate_shape()
	
func _draw():
	var direction := velocity  # Your node's velocity vector
	var start_point := Vector2.ZERO
	var end_point := direction.normalized() * 100.0
	var arrow_head_size := 10

	draw_line(start_point, end_point, Color.WHITE, 2)
	var perp1 := direction.normalized().rotated(PI/6) * arrow_head_size
	var perp2 := direction.normalized().rotated(-PI/6) * arrow_head_size

	draw_line(end_point, end_point - perp1, Color.WHITE, 2)
	draw_line(end_point, end_point - perp2, Color.WHITE, 2)

func _physics_process(delta: float) -> void:
	_calculate_shape()
	
	if GameState.game_started:
		$bounce.emitting = false
		if velocity.length() > 0.0:
			$trail.emitting = true
		else:
			$trail.emitting = false
		var collision_info := move_and_collide(velocity * delta)
		if collision_info:
			_flash_color()
			$AudioStreamPlayer2D.play()
			var bounce_direction := collision_info.get_collider_velocity()
			velocity = velocity.bounce(collision_info.get_normal())
			if bounce_direction.y != 0:
				if sign(bounce_direction.y) != sign(velocity.y):
					velocity *= -1
			#velocity = Vector2(velocity.x, velocity.y * (1 + randf_range(0.05, 0.15)))
			$bounce.emitting = true
			
	queue_redraw()
		

func _calculate_shape() -> void:
	if not is_inside_tree():
		return
	
	var size := Vector2(width, height)
	var shape := $CollisionShape2D.shape as RectangleShape2D
	shape.size = size
	
	$ColorRect.position = Vector2(-size.x / 2.0, -size.y / 2.0)
	$ColorRect.size = size
	$ColorRect.color = Color.WHITE
	
func go() -> void:
	var y_direction := randf_range(0.1, 0.3) * (randi() % 2 * 2 - 1)
	var direction := Vector2(1.0, y_direction)
	velocity = direction.normalized() * START_SPEED
	GameState.game_started = true
	
func _flash_color() -> void:
	var original_color: Color = $ColorRect.color
	
	# Tween to flash color
	var tween := create_tween()
	tween.tween_property($ColorRect, "color", Color.RED, 0.2 / 2)
	tween.tween_property($ColorRect, "color", original_color, 0.2 / 2)
	

extends Area2D

@export var is_player := false

@onready var audio_stream_player_2d: AudioStreamPlayer2D = %AudioStreamPlayer2D
@onready var game := $".."

func _on_body_entered(body: Node2D) -> void:
	if body is Ball:
		if not is_player:
			GameState.player_score += 1
		else:
			GameState.ai_score += 1
		GameState.game_started = false
		audio_stream_player_2d.play()
		game.reset()
	

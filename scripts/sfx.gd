extends AudioStreamPlayer
class_name SoundEffect

func _ready() -> void:
	play()
	
	
func on_sfx_finished() -> void:
	queue_free()

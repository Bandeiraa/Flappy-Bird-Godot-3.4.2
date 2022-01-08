extends Node2D
class_name Pipe

onready var top_pipe: StaticBody2D = get_node("TopPipe")
onready var bottom_pipe: StaticBody2D = get_node("BottomPipe")

export(int) var walk_speed
export(PackedScene) var sfx_scene
export(Array, String) var pipe_texture

func _ready() -> void:
	randomize()
	var random_number: int = randi() % pipe_texture.size()
	top_pipe.get_node("Texture").texture = load(pipe_texture[random_number])
	bottom_pipe.get_node("Texture").texture = load(pipe_texture[random_number])
	
	
func _physics_process(delta: float) -> void:
	position.x -= delta * walk_speed
	
	
func on_screen_exited() -> void:
	queue_free()
	
	
func game_over() -> void:
	top_pipe.get_node("Collision").set_deferred("disabled", true)
	bottom_pipe.get_node("Collision").set_deferred("disabled", true)
	set_physics_process(false)
	
	
func on_body_exited(body: Bird) -> void:
	if body is Bird and body.global_position.x > get_node("ScoreArea").global_position.x:
		spawn_sfx("res://assets/sfx/point.ogg")
		get_tree().call_group("Interface", "update_score")
		
		
func spawn_sfx(effect: String) -> void:
	var sfx: SoundEffect = sfx_scene.instance()
	sfx.stream = load(effect)
	get_tree().root.call_deferred("add_child", sfx)

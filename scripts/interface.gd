extends CanvasLayer

signal start_game

onready var animation: AnimationPlayer = get_node("Animation")
onready var score_container: Control = get_node("ScoreContainer")
onready var button_container: Control = get_node("MessageContainer")

var score: int = 0

func _ready() -> void:
	animation.play("fade_out")
	for button in button_container.get_children():
		button.connect("pressed", self, "on_button_pressed", [button])
		
		
func on_button_pressed(button: Button) -> void:
	match button.name:
		"Message":
			button_container.get_node("Message").hide()
			score_container.show()
			emit_signal("start_game")
			
		"Gameover":
			animation.play("fade_in")
			yield(get_tree().create_timer(1.0), "timeout")
			var _reload = get_tree().reload_current_scene()
			
			
func update_score() -> void:
	score += 1
	score_container.get_node("Score").text = str(score)
	
	
func game_over() -> void:
	button_container.get_node("Gameover").show()

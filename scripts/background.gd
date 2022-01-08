extends ParallaxBackground

onready var background_texture: TextureRect = get_node("Background/Texture")

export(int) var scenario_speed
export(Array, String) var scenario_texture

func _ready() -> void:
	randomize()
	var random_number: int = randi() % scenario_texture.size()
	background_texture.texture = load(scenario_texture[random_number])
	
	
func _physics_process(delta: float) -> void:
	for children in get_children():
		if children is ParallaxLayer:
			children.motion_offset.x -= scenario_speed * delta
			
			
func game_over() -> void:
	set_physics_process(false)

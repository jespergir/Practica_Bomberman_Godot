extends Area2D

@onready var animations : AnimatedSprite2D = $AnimatedSprite2D

const PIXELS : int = 32
var tween : Tween
var moving : bool = false
var current_idle = "idle_front"

func _ready() -> void:
	pass
	
	
func _process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_back", "move_front")
	if direction && !moving:
		moving = true
		move_me(direction)
	if !direction && !moving:
		animations.play(current_idle)


func move_me(direction):
	
	var next_position : Vector2
	
	if direction.x < 0:
		next_position = position + Vector2(-PIXELS, 0)
		animations.play("walk_left")
		current_idle = "idle_left"
		move_by_tween(next_position)
		#left
	elif direction.x > 0:
		#right
		next_position = position + Vector2(PIXELS, 0)
		animations.play("walk_right")
		current_idle = "idle_right"
		move_by_tween(next_position)
	elif direction.y < 0:
		#back
		next_position = position + Vector2(0, -PIXELS)
		animations.play("walk_back")
		current_idle = "idle_back"
		move_by_tween(next_position)
	elif direction.y > 0:
		#front
		next_position = position + Vector2(0, PIXELS)
		animations.play("walk_front")
		current_idle = "idle_front"
		move_by_tween(next_position)


func move_by_tween(next_position : Vector2):
		tween = create_tween()
		tween.tween_property(self, "position", next_position, 0.2)
		tween.tween_callback(end_of_tween)

func end_of_tween():
	moving = false;

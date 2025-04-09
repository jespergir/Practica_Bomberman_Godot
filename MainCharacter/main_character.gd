extends Area2D

@onready var animations : AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_up : RayCast2D = $RayCasts/Up
@onready var ray_down : RayCast2D = $RayCasts/Down
@onready var ray_left : RayCast2D = $RayCasts/Left
@onready var ray_right : RayCast2D = $RayCasts/Right


var bomb : PackedScene = preload("res://Bomb/bomb.tscn")

const PIXELS : int = 32
var tween : Tween
var moving : bool = false
var current_idle = "idle_front"
@onready var valid_position = position

func _ready() -> void:
	pass
	
	
func _process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_back", "move_front")
		#if Input.is_action_just_pressed("place_bomb"):
	if direction && !moving:
		move_me(direction)
	if !direction && !moving:
		animations.play(current_idle)


func _input(event: InputEvent) -> void:	
	if event.is_action_pressed("place_bomb"):
		var newbomb = bomb.instantiate()
		newbomb.position = valid_position
		add_sibling(newbomb)
	

func move_me(direction):
	
	var next_position : Vector2
	
	if direction.x < 0 && !ray_left.is_colliding():#left
		next_position = position + Vector2(-PIXELS, 0)
		animations.play("walk_left")
		current_idle = "idle_left"
		move_by_tween(next_position)
	elif direction.x > 0 && !ray_right.is_colliding():#right
		next_position = position + Vector2(PIXELS, 0)
		animations.play("walk_right")
		current_idle = "idle_right"
		move_by_tween(next_position)
	elif direction.y < 0 && !ray_up.is_colliding():#back
		next_position = position + Vector2(0, -PIXELS)
		animations.play("walk_back")
		current_idle = "idle_back"
		move_by_tween(next_position)
	elif direction.y > 0 && !ray_down.is_colliding():#front
		next_position = position + Vector2(0, PIXELS)
		animations.play("walk_front")
		current_idle = "idle_front"
		move_by_tween(next_position)
	else:
		animations.play(current_idle)


func move_by_tween(next_position : Vector2):
		moving = true
		valid_position = next_position
		tween = create_tween()
		tween.tween_property(self, "position", next_position, 0.2)
		tween.tween_callback(end_of_tween)

func end_of_tween():
	moving = false;


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bomb"):
		print("ma ha dado la bomba")
	if area.is_in_group("pickable_key"):
		print("recojo key")
	if area.is_in_group("pickable_bomb"):
		print("recojo bomb")
	if area.is_in_group("portal"):
		print("he ganado!")

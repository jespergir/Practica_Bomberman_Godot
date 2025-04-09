extends Node2D
class_name LevelClass

var pickable_bomb : PackedScene = preload("res://PickableItems/pickable_bomb.tscn")
var pickable_key : PackedScene = preload("res://PickableItems/pickable_key.tscn")
var portal : PackedScene = preload("res://Portal/portal.tscn")
var key_popped : bool = false
var portal_popped : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

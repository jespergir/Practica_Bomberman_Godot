extends Node2D

@onready var path_follow : PathFollow2D = $Path2D/PathFollow2D
@onready var animation : AnimationPlayer = $AnimationPlayer

var tween = Tween


func _ready() -> void:
	init_tween()
	


func _process(delta: float) -> void:
	pass


func init_tween():
	tween = create_tween()
	tween.tween_property(path_follow, "progress_ratio", 1, 3)
	tween.tween_callback(detonate)
	
func detonate():
	animation.play("detonation")

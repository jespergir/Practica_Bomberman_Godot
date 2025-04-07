extends StaticBody2D

func _ready() -> void:
	pass
	
	
func _process(delta: float) -> void:
	pass
	
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bomba"):
		$AnimationPlayer.play("destroy")

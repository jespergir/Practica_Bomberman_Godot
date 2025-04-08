extends Area2D

class_name PickableItem
@onready var animation : AnimatedSprite2D = $animacion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation.play("bounce")
	self.area_entered.connect(_on_area_entered)
	

func _on_area_entered(area: Area2D):
	if area.is_in_group("personaje"):
		queue_free()

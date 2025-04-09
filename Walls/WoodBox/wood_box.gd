extends StaticBody2D

@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var initialBoxCount = get_parent().get_child_count();
@onready var level : LevelClass = get_tree().get_first_node_in_group("level")
static var box_count;

func _ready() -> void:
	box_count = initialBoxCount;
	
	
func _process(delta: float) -> void:
	pass
	
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bomb"):
		$AnimationPlayer.play("destroy")
		box_count -=1
		call_deferred("spawn_item")

func spawn_item():
	var key_prob : float = 100.0/box_count
	var randomNum : float = randf_range(0,100)
	if randomNum < key_prob:
		pop_key()
	else:
		pop_dyn()
	
func pop_dyn():
	var num : int = randi_range(1,10)
	print("Quedan ", box_count, " cajas")
	if num<=5:
		put_item(level.pickable_bomb)
		
func pop_key():
	if !level.key_popped:
		level.key_popped = true
		put_item(level.pickable_key)
	elif !level.portal_popped:
		level.portal_popped=true
		put_item(level.portal)
		
func put_item(item : PackedScene):
	var new_item = item.instantiate()
	new_item.position = position
	level.add_child(new_item)

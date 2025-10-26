class_name itemAgarrable extends AnimatableBody3D

var stop_falling: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if stop_falling == false:
		position.y -= delta * 15
	
func _on_base_body_entered(body: Node3D) -> void:
	stop_falling = true 

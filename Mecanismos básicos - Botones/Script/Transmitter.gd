class_name Transmitter 
extends AnimatableBody3D

signal emit_signal

func _ready() -> void:
	#print("Testing emission...") 
	#trigger_emission()
	pass
	
func can_emit() -> bool:
	return has_method("on_emission_triggered")
	
func trigger_emission():
	if can_emit(): call("on_emission_triggered")
	else: print("No se ha detectado funcion on_emission_triggered")

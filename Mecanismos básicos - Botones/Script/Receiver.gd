class_name Reciever
extends AnimatableBody3D


func _ready() -> void:
	#print("COmprobando receptor...") 
	#send_to_receptor(true)
	pass
	
func can_receive() -> bool:
	return has_method("on_signal_received")

func send_to_receptor(payload):
	if can_receive():
		call("on_signal_received", payload)
	else:
		print("No se ha detectado funcion on_signal_received")

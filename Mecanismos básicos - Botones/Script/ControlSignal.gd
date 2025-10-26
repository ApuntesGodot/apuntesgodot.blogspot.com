class_name ControlSignal extends Node

@export var receptores: Array[Reciever] = []
@export var emisores: Array[Transmitter] = []
@export var needAllTransmitterActive : bool = true 

var status_transmision: Dictionary = {}

signal transmit_signal

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	emisores = emisores.filter(func(e): return e != null)
	receptores = receptores.filter(func(e): return e != null)
	for r in receptores:
		transmit_signal.connect(r.send_to_receptor)
			
	for e in emisores:
			e.emit_signal.connect(recieve_signal)
			e.trigger_emission()

func recieve_signal(name_singal,value_signal):
	status_transmision[name_singal] = value_signal
	transmit_signal.emit(check_all_transmitter(needAllTransmitterActive))

	
func check_all_transmitter(allRequired) -> bool :
	var status = true
	for valor in status_transmision.values():	
		print(valor)	
		if  allRequired and valor == false:
			status = false
			break
		elif allRequired==false and valor == true:
			break				
	return status
	
	
	
		

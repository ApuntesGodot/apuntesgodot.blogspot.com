class_name Boton  extends Transmitter

@export var estaPresionado: bool = false
@export var necestiaPresion : bool = true

@onready var presionado: MeshInstance3D = $Presionado
@onready var sin_presionar: MeshInstance3D = $SinPresionar
@onready var sensor: RayCast3D = $RayCast3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if estaPresionado:
		presionar()
	elif not estaPresionado and not sensor.is_colliding():
		desPresionar()
		
	elif sensor.is_colliding():
		presionar()
	
	super()	
	pass # Replace with function body.

func presionar():
	presionado.visible = true
	sin_presionar.visible = !presionado.visible
	emit_signal.emit(true)
	
func desPresionar():
	presionado.visible = false
	sin_presionar.visible = !presionado.visible
	emit_signal.emit(false)

func _on_area_3d_body_entered(body: Node3D) -> void:
	presionar()
	emitButtonStatus()	

func _on_area_3d_body_exited(body: Node3D) -> void:
	print(sensor.is_colliding())
	if necestiaPresion and $Area3D.get_overlapping_bodies().size() == 0:
		desPresionar()
		emitButtonStatus()

func emitButtonStatus():
	emit_signal.emit(name,presionado.visible)

func on_emission_triggered():
	emitButtonStatus()

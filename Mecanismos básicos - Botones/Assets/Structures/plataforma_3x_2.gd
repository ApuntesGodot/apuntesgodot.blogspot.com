class_name Plataforma extends Reciever

@export var auto_start : bool = true

@export var a := Vector3()
@export var b := Vector3()
@export var time : float = 2.0
@export var pause : float = 0.7

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	super()
	move()
	
func move():
	if auto_start:
		irPuntoB()
		irPuntoA()

		await get_tree().create_timer(2 * time + 2 * pause).timeout
		move()

func irPuntoA():
	var move_tween = create_tween()
	
	move_tween.tween_property(self,"position", a, time ).set_trans(Tween.TRANS_SINE).set_delay(pause)

func irPuntoB():
	var move_tween = create_tween()

	move_tween.tween_property(self,"position", b, time ).set_trans(Tween.TRANS_SINE).set_delay(pause)

func on_signal_received(status):
	if status:
		irPuntoB()
	elif !status:
		irPuntoA()

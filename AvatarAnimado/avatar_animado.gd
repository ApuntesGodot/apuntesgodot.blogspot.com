extends Node2D

@onready var face_selector: OptionButton = $Control/OptionButton
@onready var cara: Sprite2D = $Busto/Cara
@onready var busto: Sprite2D = $Busto

# Estramos el ancho y la altura de los region rect de busto y cara
# No nos interesa el ancho del busto para sacar la posicion de las caras.
var altura_busto = Vector2(0,250)
var tamaño_cara = Vector2(63,57)

var faces = {
	"neutral": Vector2(0, 0),
	"determinada": Vector2(1, 0),
	"enfadada": Vector2(2, 0),
	
	"indignada": Vector2(0, 1),
	"decepcionada": Vector2(1, 1),
	"sorprendia": Vector2(2, 1),
	
	"triste": Vector2(0,2),
	"asustada": Vector2(1,2),
	
	"feliz": Vector2(0,3),
	"sonrojada": Vector2(1,3)
	
}

func _ready() -> void:
	for name in faces.keys():
		face_selector.add_item(name)

func setFace(coords):
	#cara.region_enabled = true  # Asegúrate de que está activado
	# El punto Y de incio es la altura del Busto.
	# Calculamos la posicion de las caras sin tener en cuenta las separación.
	# Calculamos la distancia entre caras.
	# Calculamos el espacio que tiene la primera columna y fila.                                                     
	var posicion_cara = altura_busto + tamaño_cara*coords + (coords * Vector2(3,3)) + Vector2(2,3)
	print(posicion_cara)
	print(posicion_cara)
	cara.region_rect = Rect2(posicion_cara,tamaño_cara)
	
func _on_button_button_down() -> void:
	var selected_text = face_selector.get_item_text(face_selector.selected)
	if selected_text in faces:
		setFace(faces[selected_text])
	else:
		print("cara no encontrada")

class_name Etiqueta extends Label

@export var comando : String
@export var habilitado : bool = true

func _ready():
	if !habilitado:
		deshabilitar()
	
	
func deshabilitar():
	add_theme_color_override("font_color", Color("red"))
	habilitado = false

func habilitar():
	add_theme_color_override("font_color", Color("black"))
	habilitado = true
		
func ocultar():
	visible = false
	set_custom_minimum_size(Vector2.ZERO)  # quita la restricció

func mostrar():
	visible = true
	set_custom_minimum_size(Vector2())  # quita la restricció	

func renombrar(txt):
	text = txt

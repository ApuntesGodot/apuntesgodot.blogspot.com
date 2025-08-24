class_name MenuDinamico extends MarginContainer

var index_selected : int = 0

@onready var selector: Sprite2D = $Selector
@onready var vbc: VBoxContainer = $NinePatchRect/VBoxContainer

@onready var labels = vbc.find_children("*", "Label", true, false)

signal llamar_funcion(funcion)
 
func _ready():
	await get_tree().process_frame    # deja que el layout se calcule
	ajustar_tamaño_menu()
	opcion_seleccionada()


func ajustar_tamaño_menu():
	vbc.size.y = 0 # Se reduce al minimo, se usa para reajustar en el caso de querer quitar una Label.
	size.y = vbc.size.y + 9
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		index_selected = clamp(index_selected-1,0,labels.size())
		opcion_seleccionada()
		
	if Input.is_action_just_pressed("ui_down"):
		index_selected = clamp(index_selected+1,0,labels.size()-1)
		opcion_seleccionada()
			
	if Input.is_action_just_pressed("ui_accept"):
		emitir_señal()
		
func emitir_señal():
	llamar_funcion.emit(index_selected)
	print(index_selected)

func opcion_seleccionada():	
	selector.global_position = labels[index_selected].global_position

# Oculta y colapsa (no ocupa espacio)
func ocultar_opcion(index) -> void:
	labels[index].ocultar()
	ajustar_tamaño_menu()
# Muestra y deja que el contenedor lo mida de nuevo
func mostrar_opcion(index) -> void:
	labels[index].mostrar()
	ajustar_tamaño_menu()

func renombrar_opcion(index, text):
	labels[index].text = text

class_name MenuDinamico extends MarginContainer

var index_selected : int = -1

@onready var selector: Sprite2D = $Selector
@onready var vbc: VBoxContainer = $NinePatchRect/VBoxContainer

@onready var labels = vbc.find_children("*", "Etiqueta", true, false)

signal llamar_funcion(funcion)
 
func _ready():
	await get_tree().process_frame    # deja que el layout se calcule
	ajustar_tamaño_menu()
	# Buscamos la primera opción visible. 
	seleccionarOpcionVisible()
	opcion_seleccionada()
		
	# Prueba
	#ocultar_opcion(0)
	#ocultar_opcion(1)
	#deshabilitar_opcion(2)
	#renombrar_opcion(3,"OPCION MODIFICADO")

func seleccionarOpcionVisible():
	for index in labels.size():
		if labels[index].visible == true:
			index_selected = index
			break
			
func ajustar_tamaño_menu():
	vbc.size.y = 0 # Se reduce al minimo, se usa para reajustar en el caso de querer quitar una Label.
	size.y = vbc.size.y + 9
	size.x = vbc.size.x + 9
	
func _process(delta: float) -> void:
	var index_tmp = index_selected
	
	if Input.is_action_just_pressed("ui_up"):
		index_selected = clamp(index_selected-1,0,labels.size())
		if !labels[index_selected].visible:
			index_selected = clamp(index_selected-1,0,labels.size())
			if !labels[index_selected].visible:
				index_selected = index_tmp

			
		opcion_seleccionada()
		
	if Input.is_action_just_pressed("ui_down"):
		index_selected = clamp(index_selected+1,0,labels.size()-1)
		if !labels[index_selected].visible:
			index_selected = clamp(index_selected+1,0,labels.size()-1)
			if !labels[index_selected].visible:
				index_selected = index_tmp		
		
		opcion_seleccionada()
			
	if Input.is_action_just_pressed("ui_accept"):
		emitir_señal()
		
func emitir_señal():
	if labels[index_selected].habilitado == true:
		llamar_funcion.emit(labels[index_selected].comando)
		print("El comando "+labels[index_selected].comando+" se ha emitido")
	else:
		print("El comando "+labels[index_selected].comando+" no se ha emitido")
		
func opcion_seleccionada():	
	selector.global_position = labels[index_selected].global_position
	
func ocultar_opcion(index) -> void:
	labels[index].ocultar()
	ajustar_tamaño_menu()

func mostrar_opcion(index) -> void:
	labels[index].mostrar()
	ajustar_tamaño_menu()

func deshabilitar_opcion(index) -> void:
	labels[index].deshabilitar()
	
func habilitar_opcion(index) -> void:
	labels[index].habilitar()
	
func renombrar_opcion(index, text):
	labels[index].renombrar(text)
	ajustar_tamaño_menu()
	

class_name agarrarBloques extends Node

var item_en_area : itemAgarrable = null
var item_agarrado : itemAgarrable = null

@export var PosicionItemAgarrado : Marker3D
@export var DetectarItemsEnArea : Area3D
@export var PuedesAgarrarElItem : MeshInstance3D

func _ready() -> void:
	PuedesAgarrarElItem.visible = false
	DetectarItemsEnArea.body_entered.connect(_on_detectar_item_entered)
	DetectarItemsEnArea.body_exited.connect(_on_detectar_item_exited)
	
func _on_detectar_item_entered(body: itemAgarrable) -> void:
	PuedesAgarrarElItem.visible = true
	item_en_area = body	

func _on_detectar_item_exited(body: itemAgarrable) -> void:
	item_en_area = null
	PuedesAgarrarElItem.visible = false

func _process(delta: float) -> void:	
	if item_agarrado != null:
		item_agarrado.global_position = PosicionItemAgarrado.global_position
	
	if Input.is_key_pressed(KEY_E) and InputMap.has_action("Interaction")==false:
		print("Crear INPUTMAP Interaction")
		
	if Input.is_action_just_pressed("Interaction"):		
		if(item_agarrado != null and item_en_area == null):
			item_agarrado.stop_falling = false
			item_agarrado = null
			
		elif(item_en_area!=null):
			item_agarrado = item_en_area
		

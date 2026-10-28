extends PanelContainer

@export var items: Array[ItemData] = []
@export var item_scene: PackedScene
@onready var grilla_item: GridContainer = %Grilla


func _ready() -> void:
	for item_data in items:
		agregar_item(item_data)


func agregar_item(item_data: ItemData) -> void:
	var nuevo_item = item_scene.instantiate()
	nuevo_item.data = item_data
	add_child(nuevo_item)
	var exito = grilla_item.intentar_agregar_item_data(nuevo_item)
	if not exito:
		nuevo_item.queue_free()

extends Sprite2D

const TAMAÑO_SLOT: int = 64

var data: ItemData = null
var esta_agarrado: bool = false

var tamaño: Vector2:
	get():
		return Vector2(data.dimensiones) * TAMAÑO_SLOT

var ancla: Vector2:
	get():
		return global_position - tamaño / 2


func _ready() -> void:
	if data and data.texture:
		texture = data.texture
		scale = tamaño / texture.get_size()


func _process(_delta: float) -> void:
	if esta_agarrado:
		global_position = get_global_mouse_position()


func set_posicion_inicial(pos: Vector2) -> void:
	global_position = pos + tamaño / 2


func agarrar() -> void:
	esta_agarrado = true
	z_index = 10
	add_to_group("item_agarrado")


func colocar(pos: Vector2i) -> void:
	esta_agarrado = false
	z_index = 0
	global_position = Vector2(pos) + tamaño / 2
	remove_from_group("item_agarrado")

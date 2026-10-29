extends Sprite2D

const TAMAÑO_SLOT: int = 64
const DURACION_ROTACION: float = 0.1

var data: ItemData = null
var esta_agarrado: bool = false
var pasos_rotacion: int = 0

var _grados_objetivo: float = 0.0
var _tween: Tween

var dimensiones: Vector2i:
	get():
		if pasos_rotacion % 2 == 1:
			return Vector2i(data.dimensiones.y, data.dimensiones.x)
		return data.dimensiones

var tamaño: Vector2:
	get():
		return Vector2(dimensiones) * TAMAÑO_SLOT

var ancla: Vector2:
	get():
		return global_position - tamaño / 2


func _ready() -> void:
	if data and data.texture:
		texture = data.texture
		scale = Vector2(data.dimensiones) * TAMAÑO_SLOT / texture.get_size()


func _process(_delta: float) -> void:
	if esta_agarrado:
		global_position = get_global_mouse_position()


func _unhandled_input(event: InputEvent) -> void:
	if esta_agarrado and event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_R:
		rotar()


func rotar() -> void:
	pasos_rotacion = (pasos_rotacion + 1) % 4
	_grados_objetivo += 90.0
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, "rotation_degrees", _grados_objetivo, DURACION_ROTACION)


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

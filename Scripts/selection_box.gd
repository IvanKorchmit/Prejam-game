class_name SelectionBox extends Node2D


static var selection: SelectionBox

var last_click: Vector2
var selected_units: Array[Node2D] = []
var r: Rect2

@onready var selection_area = $Area2D
@onready var coll = $Area2D/CollisionShape2D

func _ready():
	selection = self


func _draw():
	r = Rect2(last_click, get_local_mouse_position() - last_click)
	
	if Input.is_action_pressed("lmb"):
		draw_rect(r, Color.GREEN, false, 1.0)


func _process(_delta):
	if Input.is_action_just_pressed("lmb"):
		r.size = Vector2.ZERO
		last_click = get_local_mouse_position()
	elif Input.is_action_just_released("lmb"):
		_select()
	elif Input.is_action_just_pressed("rmb"):
		_order()
	if Input.is_action_pressed("lmb"):
		selection_area.position = last_click + r.size / 2
		coll.shape.extents = r.size.abs() / 2
	queue_redraw()
	

func _clear_freed():
	selected_units = selected_units.filter(func (x): return x != null)
	
	
func _select():
	_clear_freed()
	
	for i in selected_units:
		i.unselect()
	selected_units.clear()
	var arr: Array[Node2D] = selection_area.get_overlapping_bodies()
	selected_units = arr.filter(func (x): return x.has_method("select"))
	for i in selected_units:
		i.select()


func _order():
	_clear_freed()
	for i in selected_units.filter(func(x): return x.has_method("move")):
		i.move(get_global_mouse_position())
		

func target_enemy(enemy: Node2D):
	_clear_freed()
	for i in selected_units.filter(func(x): return x.has_method("attack_enemy")):
		i.attack_enemy(enemy)

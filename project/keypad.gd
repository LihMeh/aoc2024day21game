extends GridContainer

signal move(direction: Vector2i)
signal confirm()

@export
var is_need_activation = true

var position_to_child = {}

var default_position = Vector2i(2,0)
var current_position = default_position

var active_btn_theme = load("res://active_buttons_theme.tres")
var inactive_btn_theme = load("res://buttons_theme.tres") 

func _ready():
	position_to_child[Vector2i(1,0)] = $BtnUp
	position_to_child[Vector2i(2,0)] = $BtnA
	position_to_child[Vector2i(0,1)] = $BtnLeft
	position_to_child[Vector2i(1,1)] = $BtnDown
	position_to_child[Vector2i(2,1)] = $BtnRight
	
	if is_need_activation:
		activate_btn(current_position)

func activate_btn(position:Vector2i):
	var btn = position_to_child.get(position)
	if btn:
		var b = btn as Button
		b.theme = active_btn_theme
	else:
		current_position = default_position
		activate_btn(current_position)

func deactivate_btn(position:Vector2i):
	var btn = position_to_child[position]
	var b = btn as Button
	b.theme = inactive_btn_theme

func _on_btn_a_pressed():
	confirm.emit()

func _on_btn_up_pressed():
	move.emit(Vector2i.UP)

func _on_btn_down_pressed():
	move.emit(Vector2i.DOWN)


func _on_btn_left_pressed():
	move.emit(Vector2i.LEFT)


func _on_btn_right_pressed():
	move.emit(Vector2i.RIGHT)

func on_confirm():
	position_to_child[current_position].pressed.emit()

func on_move(direction: Vector2i):
	deactivate_btn(current_position)
	current_position = current_position + direction
	activate_btn(current_position)

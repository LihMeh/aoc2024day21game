extends GridContainer

signal on_button_pressed(val)

var position_to_child = {}

var default_position = Vector2i(2,3)
var current_position = default_position

var active_btn_theme = load("res://active_buttons_theme.tres")
var inactive_btn_theme = load("res://buttons_theme.tres") 

func _ready():
	for btn in get_children():
		if btn is Button:
			btn.pressed.connect(func(): on_button_pressed.emit(btn.text))
	
	position_to_child[Vector2i(0,0)] = $Btn7
	position_to_child[Vector2i(1,0)] = $Btn8
	position_to_child[Vector2i(2,0)] = $Btn9
	position_to_child[Vector2i(0,1)] = $Btn4
	position_to_child[Vector2i(1,1)] = $Btn5
	position_to_child[Vector2i(2,1)] = $Btn6
	position_to_child[Vector2i(0,2)] = $Btn1
	position_to_child[Vector2i(1,2)] = $Btn2
	position_to_child[Vector2i(2,2)] = $Btn3
	position_to_child[Vector2i(1,3)] = $Btn0
	position_to_child[Vector2i(2,3)] = $BtnA
	
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

func confirm():
	position_to_child[current_position].pressed.emit()

func move(direction: Vector2i):
	deactivate_btn(current_position)
	current_position = current_position + direction
	activate_btn(current_position)

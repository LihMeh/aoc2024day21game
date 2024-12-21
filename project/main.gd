extends Control

# 0: <vA <AA >>^A vAA <^A >A
# 3: <v<A >>^A vA ^A
# 9: <vA >^A <v<A >^A >AA vA ^A
# A: <v<A >A >^AAA vA <^A >A

func _on_numpad_button_pressed(val):
	var output = find_child("Output") as TextEdit
	output.text = output.text + val

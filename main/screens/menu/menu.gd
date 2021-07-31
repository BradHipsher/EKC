extends Control

func _ready():
	print("Menu")
	Global.key_change = 0

func _on_begin_pressed():
	Global.change_screen("World")


func _on_calibrate_pressed():
	Global.change_screen_immediate("Calibrate")


func _on_quit_pressed():
	get_tree().quit()

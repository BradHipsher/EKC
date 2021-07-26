extends Control

func _ready():
	print("Menu")

func _on_Button_pressed():
	Global.change_screen("World")

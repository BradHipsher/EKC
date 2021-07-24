extends Control

func _ready():
	print("menu")

func _on_Button_pressed():
	Global.change_screen("room")

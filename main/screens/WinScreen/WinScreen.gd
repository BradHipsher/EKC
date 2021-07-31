extends Control

func _ready():
	get_node("container/Panel/vbox/message").text = "Congrats! You collected this many keys: " + str(Global.key_change)

func _on_menu_pressed():
	Global.change_screen_immediate("Menu")

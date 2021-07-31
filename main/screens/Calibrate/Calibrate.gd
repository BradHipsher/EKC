extends Control

var JazzLoop
var sound_direct = preload("res://engine/objects/OGGPlayer/OGGPlayer.tscn")

func _ready():
	JazzLoop = sound_direct.instance()
	JazzLoop.init("JazzLoop")
	JazzLoop.connect("pulse", self, "_on_OGGPlayer_pulse")
	#JazzLoop.connect("tick",self, "_on_OGGPlayer_tick")
	#6JazzLoop.connect("track_info", self, "_on_OGGPlayer_track_signal")
	add_child(JazzLoop)
	JazzLoop.play_sound()
	print("sound.bpm: " + str(JazzLoop.bpm))
	get_node("container/Panel/vbox/offsetSlider").value = Profile.offset
	get_node("container/Panel/vbox/songOffsetLabel").text = str(Profile.offset * 1000) + " ms"

func _on_OGGPlayer_pulse(beat_sent, time_send):
	get_node("container/Panel/vbox/spacer/PulsingTint").pulse()


func _on_offsetSlider_value_changed(value):
	get_node("container/Panel/vbox/songOffsetLabel").text = str(value * 1000) + " ms"
	get_node("container/Panel/vbox/songOffsetLabel").modulate = "#aaaaff"


func _on_setOffset_pressed():
	var offset = get_node("container/Panel/vbox/offsetSlider").value
	print(offset)
	get_node("container/Panel/vbox/songOffsetLabel").modulate = "#ffffff"
	Profile.offset = offset
	JazzLoop.stop()
	JazzLoop.queue_free()
	JazzLoop = sound_direct.instance()
	JazzLoop.init("JazzLoop")
	JazzLoop.connect("pulse", self, "_on_OGGPlayer_pulse")
	#JazzLoop.connect("tick",self, "_on_OGGPlayer_tick")
	#6JazzLoop.connect("track_info", self, "_on_OGGPlayer_track_signal")
	add_child(JazzLoop)
	JazzLoop.play_sound()
	print("sound.bpm: " + str(JazzLoop.bpm))


func _on_submit_pressed():
	Global.change_screen_immediate("Menu")
